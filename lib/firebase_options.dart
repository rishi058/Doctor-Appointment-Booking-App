// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyD0rDBu3gw5DKbaklOAFhjYJ48e_33YFG0',
    appId: '1:498028062870:web:c884f72fdcbe1493bc7ab7',
    messagingSenderId: '498028062870',
    projectId: 'clinic-app-1286f',
    authDomain: 'clinic-app-1286f.firebaseapp.com',
    storageBucket: 'clinic-app-1286f.appspot.com',
    measurementId: 'G-ZF9NHBFRK3',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCG384P3PhArcfuV5-50kUPMCpUGXUMNoM',
    appId: '1:498028062870:android:9b1c6a6c42ed9494bc7ab7',
    messagingSenderId: '498028062870',
    projectId: 'clinic-app-1286f',
    storageBucket: 'clinic-app-1286f.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCDDcAhY0oiW9uqxfsO0gDvvEoAKOEn-aU',
    appId: '1:498028062870:ios:28ffde38fe95fc88bc7ab7',
    messagingSenderId: '498028062870',
    projectId: 'clinic-app-1286f',
    storageBucket: 'clinic-app-1286f.appspot.com',
    iosBundleId: 'com.devwizards.clinicApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCDDcAhY0oiW9uqxfsO0gDvvEoAKOEn-aU',
    appId: '1:498028062870:ios:b68b5317a3c4a5b7bc7ab7',
    messagingSenderId: '498028062870',
    projectId: 'clinic-app-1286f',
    storageBucket: 'clinic-app-1286f.appspot.com',
    iosBundleId: 'com.devwizards.clinicApp.RunnerTests',
  );
}