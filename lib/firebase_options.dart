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
    apiKey: 'AIzaSyBp3ygLRegQrV_qwVONQUPAapOZf0MFCSg',
    appId: '1:930275731005:web:33f8bec87ab94cb3602c54',
    messagingSenderId: '930275731005',
    projectId: 'gamerodds-2b028',
    authDomain: 'gamerodds-2b028.firebaseapp.com',
    storageBucket: 'gamerodds-2b028.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAxBqwSIULr_xuFi6qgitgynlgM3bo92ck',
    appId: '1:930275731005:android:29b55eea24970268602c54',
    messagingSenderId: '930275731005',
    projectId: 'gamerodds-2b028',
    storageBucket: 'gamerodds-2b028.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDQnqXBHRKzzhKmdt4SiWYrn7KjY2AmvXM',
    appId: '1:930275731005:ios:854c353d7d12dd04602c54',
    messagingSenderId: '930275731005',
    projectId: 'gamerodds-2b028',
    storageBucket: 'gamerodds-2b028.appspot.com',
    iosBundleId: 'com.example.gamerOodsFlutterApplication',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDQnqXBHRKzzhKmdt4SiWYrn7KjY2AmvXM',
    appId: '1:930275731005:ios:f75792f698fdc5b0602c54',
    messagingSenderId: '930275731005',
    projectId: 'gamerodds-2b028',
    storageBucket: 'gamerodds-2b028.appspot.com',
    iosBundleId: 'com.example.gamerOodsFlutterApplication.RunnerTests',
  );
}
