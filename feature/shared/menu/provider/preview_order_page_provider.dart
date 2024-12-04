import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esc_pos_utils_plus/esc_pos_utils_plus.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:openqrx/app/provider/user_provider.dart';
import 'package:openqrx/app/util/app_state.dart';
import 'package:openqrx/app/util/print.dart';
import 'package:openqrx/domain/model/product/product.dart';
import 'package:openqrx/feature/shared/widgets/app_state/loading_app_state.dart';
import 'package:openqrx/helper/service/print_service.dart';
import 'package:openqrx/helper/service/store_service.dart';
import 'package:openqrx/helper/toast_helper.dart';
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';

class PreviewOrderPageProvider with ChangeNotifier {
  final List<Product> products;
  PreviewOrderPageProvider(this.products);
  AppState<dynamic> _widget = const AppState(noLoad: true);
  AppState<dynamic> get widget => _widget;
  void _setState(AppState<dynamic> state) {
    _widget = state;
    notifyListeners();
  }

  bool isPrinting = false;
  bool? isConnected = false;
  void _popError(String text) {
    return Toast.pop(text, error: true);
  }

  void onPrint() async {
    final enabled = await PrintBluetoothThermal.isPermissionBluetoothGranted;
    // xPrint('enabled $enabled');
    if (!enabled) {
      // final status = await Permission.bluetoothConnect.request();
      final status = await Permission.nearbyWifiDevices.request();
      return _popError('Please allow bluetoothConnect');
    }
    if (isConnected != true) {
      final isScan = await Permission.bluetoothScan.isGranted;
      if (!isScan) {
        final status = await Permission.bluetoothScan.request();
        xPrint(status);
        return _popError('Please allow scanning Bluetooth');
      }
      final isOn = await PrintBluetoothThermal.bluetoothEnabled;
      if (isOn == false) {
        return _popError('Bluetooth is off');
      }
    }
    isPrinting = true;
    notifyListeners();

    final devices = await PrintBluetoothThermal.pairedBluetooths;
    for (final device in devices) {
      if (device.name.startsWith('MP')) {
        isConnected = await PrintBluetoothThermal.connectionStatus;
        if (isConnected == true) {
          break;
        } else {
          try {
            isConnected = await PrintBluetoothThermal.connect(
                macPrinterAddress: device.macAdress);
            if (isConnected == true) {
              break;
            }
          } catch (e) {
            isConnected = false;
            xPrint(e, error: true);
          }
        }
      }
    }
    if (isConnected == true) {
      final profile = await CapabilityProfile.load();
      final generator = Generator(PaperSize.mm58, profile);
      List<int> bytes = [];
      bytes += generator.reset();
      final pngBytes =
          await PrintService.instance.getPdfByte(products, scale: 2.25);
      bytes += generator.imageRaster(img.decodePng(pngBytes!)!,
          align: PosAlign.left);
      bytes += generator.feed(4);
      await PrintBluetoothThermal.writeBytes(bytes);
    } else {
      _popError('Can not connect to printer');
    }
    isPrinting = false;
    notifyListeners();
  }

  void onSubmit(BuildContext context) async {
    int sumTotal = products.fold(0, (previousValue, element) {
      return previousValue + (element.qty * element.price).toInt();
    });

    if (sumTotal == 0) {
      return _popError('អត់លេខ');
    }
    final dayId = DateFormat('dd-MM-yyyy').format(DateTime.now());
    xPrint(dayId);
    final data = {
      'total': sumTotal,
      'products': products.map((e) => e.toJson()).toList(),
      'createdAt': FieldValue.serverTimestamp(),
      'dayId': dayId,
    };
    // xPrint(lucky);

    _setState(widget.alert(const LoadingAppState()));
    try {
      final farmId = UserProvider.instance.defaultFarm;
      await StoreService.instance.collection('Farm/$farmId/Order').add(data);
      // onPrint();
    } catch (e) {
      xPrint(e);
      _popError('$e');
    }
    await Future.delayed(const Duration(seconds: 3));
    if (context.mounted) {
      Navigator.pop(context);
    }
    // _setState(widget.popFloat());
  }
  // void submit() async {
  //   _setState(_widget.alert(const LoadingAppState()));
  //   await Future.delayed(const Duration(seconds: 3));
  //   _setState(_widget.alert(null));
  // }
}
