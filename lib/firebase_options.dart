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
    apiKey: 'AIzaSyAPAs4KvnioEbPDqlG3EYb4yWag1jU-00I',
    appId: '1:705415177594:web:d5e6f626d5cd66d63fa2c3',
    messagingSenderId: '705415177594',
    projectId: 'homework4-12f46',
    authDomain: 'homework4-12f46.firebaseapp.com',
    storageBucket: 'homework4-12f46.appspot.com',
    measurementId: 'G-J6W76BMZWS',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA3YZPOYoFF5qyJo6FVYVwaWJt7RKYABI0',
    appId: '1:705415177594:android:c62e92a1e1212fef3fa2c3',
    messagingSenderId: '705415177594',
    projectId: 'homework4-12f46',
    storageBucket: 'homework4-12f46.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAzLDX-fAjhoYUlS2nzWnt8dMP9lkQDmhc',
    appId: '1:705415177594:ios:f4d6f2f4824824803fa2c3',
    messagingSenderId: '705415177594',
    projectId: 'homework4-12f46',
    storageBucket: 'homework4-12f46.appspot.com',
    iosBundleId: 'com.example.messageBoardApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAzLDX-fAjhoYUlS2nzWnt8dMP9lkQDmhc',
    appId: '1:705415177594:ios:afd237e06b6102cc3fa2c3',
    messagingSenderId: '705415177594',
    projectId: 'homework4-12f46',
    storageBucket: 'homework4-12f46.appspot.com',
    iosBundleId: 'com.example.messageBoardApp.RunnerTests',
  );
}