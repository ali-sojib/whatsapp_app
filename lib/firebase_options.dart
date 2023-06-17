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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDX6E9YlTezmefpt0-KeFEQHea-CWAWACs',
    appId: '1:70517563299:android:39ef7c91f43bf1080f8416',
    messagingSenderId: '70517563299',
    projectId: 'whatsapp-backends-af0c8',
    storageBucket: 'whatsapp-backends-af0c8.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCUe2YUst0awYRhdCVX8xHneYLXTeHnrdQ',
    appId: '1:70517563299:ios:e392e1c6914e2c140f8416',
    messagingSenderId: '70517563299',
    projectId: 'whatsapp-backends-af0c8',
    storageBucket: 'whatsapp-backends-af0c8.appspot.com',
    androidClientId: '70517563299-l01fuj9ae67ajnurcmrlcc3fi7e174gf.apps.googleusercontent.com',
    iosClientId: '70517563299-05og8u489baifja0rrer3jdsrais9k3r.apps.googleusercontent.com',
    iosBundleId: 'com.example.whatsappApp',
  );
}
