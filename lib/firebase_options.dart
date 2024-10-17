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
    apiKey: 'AIzaSyDFR9vT5lQUIbKOZXAKRYf6HWOUTYkNfkQ',
    appId: '1:308976433430:web:5118be9b5cd8d70168b837',
    messagingSenderId: '308976433430',
    projectId: 'compras-mayoristas',
    authDomain: 'compras-mayoristas.firebaseapp.com',
    storageBucket: 'compras-mayoristas.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCP4gNrU1NTvJPTOTqh-Gn2KaOpDSKhQjY',
    appId: '1:308976433430:android:9d730f5f4e7ef05568b837',
    messagingSenderId: '308976433430',
    projectId: 'compras-mayoristas',
    storageBucket: 'compras-mayoristas.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCKmrvabtcAxXcm2rlRxQl4tl9WCo4YjIE',
    appId: '1:308976433430:ios:6e641e9b35ff73ea68b837',
    messagingSenderId: '308976433430',
    projectId: 'compras-mayoristas',
    storageBucket: 'compras-mayoristas.appspot.com',
    iosBundleId: 'com.example.test01',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCKmrvabtcAxXcm2rlRxQl4tl9WCo4YjIE',
    appId: '1:308976433430:ios:6e641e9b35ff73ea68b837',
    messagingSenderId: '308976433430',
    projectId: 'compras-mayoristas',
    storageBucket: 'compras-mayoristas.appspot.com',
    iosBundleId: 'com.example.test01',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDFR9vT5lQUIbKOZXAKRYf6HWOUTYkNfkQ',
    appId: '1:308976433430:web:cac1ecd6dbaa79bb68b837',
    messagingSenderId: '308976433430',
    projectId: 'compras-mayoristas',
    authDomain: 'compras-mayoristas.firebaseapp.com',
    storageBucket: 'compras-mayoristas.appspot.com',
  );
}