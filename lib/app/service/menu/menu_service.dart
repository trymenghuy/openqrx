// import 'package:permission_handler/permission_handler.dart';
// import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';

// class MenuService {
//   Future<void> isConnect() async {}
//   Future<bool> isPrintEnable() async {
//     final enabled = await PrintBluetoothThermal.isPermissionBluetoothGranted;
//     // xPrint('enabled $enabled');
//     if (!enabled) {
//       // final status = await Permission.bluetoothConnect.request();
//       final status = await Permission.nearbyWifiDevices.request();
//     }
//     return enabled;
//   }

//   void print() async {
//     final enabled = await PrintBluetoothThermal.isPermissionBluetoothGranted;
//     // xPrint('enabled $enabled');
//     if (!enabled) {
//       // final status = await Permission.bluetoothConnect.request();
//       final status = await Permission.nearbyWifiDevices.request();
//       return _popError('Please allow bluetoothConnect');
//     }
//     if (isConnected != true) {
//       final isScan = await Permission.bluetoothScan.isGranted;
//       if (!isScan) {
//         final status = await Permission.bluetoothScan.request();
//         xPrint(status);
//         return _popError('Please allow scanning Bluetooth');
//       }
//       final isOn = await PrintBluetoothThermal.bluetoothEnabled;
//       if (isOn == false) {
//         return _popError('Bluetooth is off');
//       }
//     }
//     isPrinting = true;
//     notifyListeners();

//     final devices = await PrintBluetoothThermal.pairedBluetooths;
//     for (final device in devices) {
//       if (device.name.startsWith('MP')) {
//         isConnected = await PrintBluetoothThermal.connectionStatus;
//         if (isConnected == true) {
//           break;
//         } else {
//           try {
//             isConnected = await PrintBluetoothThermal.connect(
//                 macPrinterAddress: device.macAdress);
//             if (isConnected == true) {
//               break;
//             }
//           } catch (e) {
//             isConnected = false;
//             xPrint(e, error: true);
//           }
//         }
//       }
//     }
//     if (isConnected == true) {
//       final profile = await CapabilityProfile.load();
//       final generator = Generator(PaperSize.mm58, profile);
//       List<int> bytes = [];
//       bytes += generator.reset();
//       final pngBytes =
//           await PrintService.instance.getPdfByte(products, scale: 2.25);
//       bytes += generator.imageRaster(img.decodePng(pngBytes!)!,
//           align: PosAlign.left);
//       bytes += generator.feed(4);
//       await PrintBluetoothThermal.writeBytes(bytes);
//     } else {
//       _popError('Can not connect to printer');
//     }
//     isPrinting = false;
//     notifyListeners();
//   }
// }
