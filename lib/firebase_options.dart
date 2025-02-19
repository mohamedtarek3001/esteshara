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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBwid5nxyxcD8JFDtC8mqE9ymPBjS86-7Y',
    appId: '1:763019627626:android:15f570ea5c577826b44e13',
    messagingSenderId: '763019627626',
    projectId: 'estsharti-f4f06',
    storageBucket: 'estsharti-f4f06.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDKlEpU5LHtRAiV3x4IEmVaX7a0iurVFtA',
    appId: '1:763019627626:ios:30a70ff862b26d24b44e13',
    messagingSenderId: '763019627626',
    projectId: 'estsharti-f4f06',
    storageBucket: 'estsharti-f4f06.firebasestorage.app',
    iosBundleId: 'com.example.esteshara',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyC9zGht03-qQNtju-2midAt8LrK_P2114A',
    appId: '1:763019627626:web:62d04f1eb37fc96db44e13',
    messagingSenderId: '763019627626',
    projectId: 'estsharti-f4f06',
    authDomain: 'estsharti-f4f06.firebaseapp.com',
    storageBucket: 'estsharti-f4f06.firebasestorage.app',
    measurementId: 'G-LYLCYHVHB0',
  );
}
