import 'package:flutter/material.dart';
import 'package:openqrx/app/extensions/data_extensions.dart';
import 'package:openqrx/app/provider/user_provider.dart';
import 'package:openqrx/domain/model/farm/farm.dart';
import 'package:openqrx/helper/service/store_service.dart';

class FarmProvider extends ChangeNotifier {
  static FarmProvider? _instance;
  FarmProvider._();
  static FarmProvider get instance {
    _instance ??= FarmProvider._();
    return _instance!;
  }

  Farm? farm;

  Future<void> getFarm() async {
    final farmId = UserProvider.instance.defaultFarm;
    final doc =
        await StoreService.instance.collection('Farm').doc(farmId).get();
    if (doc.exists) {
      farm = Farm.fromJson(doc.data()!.setId(doc.id));
      notifyListeners();
    }
  }
}
