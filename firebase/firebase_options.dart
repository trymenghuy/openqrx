// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyB5irT5TeNUSY3tM-JBrsf8tbmuJYOLoho',
    appId: '1:434674793518:web:0e5d7103df62c20c5df3bf',
    messagingSenderId: '434674793518',
    projectId: 'tmh-pos',
    authDomain: 'tmh-pos.firebaseapp.com',
    storageBucket: 'tmh-pos.appspot.com',
    measurementId: 'G-PJRSX9G8RS',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDb1URQHjeU-23FpIyGHY9p9gHyQXYGc0Y',
    appId: '1:434674793518:android:093d339d6481405e5df3bf',
    messagingSenderId: '434674793518',
    projectId: 'tmh-pos',
    storageBucket: 'tmh-pos.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBO1wqlJcMLrgcBdf2gaF5q1r0Z8XSEYy0',
    appId: '1:434674793518:ios:fbaaf79e29e95e9d5df3bf',
    messagingSenderId: '434674793518',
    projectId: 'tmh-pos',
    storageBucket: 'tmh-pos.appspot.com',
    iosBundleId: 'com.tmh.pos',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBO1wqlJcMLrgcBdf2gaF5q1r0Z8XSEYy0',
    appId: '1:434674793518:ios:fbaaf79e29e95e9d5df3bf',
    messagingSenderId: '434674793518',
    projectId: 'tmh-pos',
    storageBucket: 'tmh-pos.appspot.com',
    iosBundleId: 'com.tmh.pos',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyB5irT5TeNUSY3tM-JBrsf8tbmuJYOLoho',
    appId: '1:434674793518:web:d2aee20e717f4ed05df3bf',
    messagingSenderId: '434674793518',
    projectId: 'tmh-pos',
    authDomain: 'tmh-pos.firebaseapp.com',
    storageBucket: 'tmh-pos.appspot.com',
    measurementId: 'G-48GYNDB8G8',
  );
}