import 'package:get_it/get_it.dart';
import 'package:openqrx/domain/repository/preference.dart';
import 'package:openqrx/domain/repository/preference_impl.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> initAppModule() async {
  final pref = await SharedPreferences.getInstance();
  // getIt.registerLazySingleton<SharedPreferences>(() => pref);
  getIt.registerLazySingleton<XPreference>(() => XPreferenceImpl(pref));
  // instance
  //     .registerLazySingleton<AppPreferences>(() => AppPreferences(instance()));
  // network info
  // getIt.registerLazySingleton<NetworkInfo>(
  //     () => NetworkInfoImpl(InternetConnectionChecker()));
  // network info

  //profile
}

Future<void> resetModules() async {
  getIt.reset(dispose: false);
  await initAppModule();
}

// Future<void> initAuth(MyProfileModel profile) async {
//   print('di initAuth');
//   if (!GetIt.I.isRegistered<AppAuth>()) {
//     instance.registerLazySingleton<AppAuth>(() => AppAuth(profile));
//   } else {
//     await instance.unregister<AppAuth>();
//     instance.registerLazySingleton<AppAuth>(() => AppAuth(profile));
//   }
// }
