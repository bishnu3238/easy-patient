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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyC0swcxjK40Nr9p9F_x1wKwZTGYPP9O6as',
    appId: '1:280548092182:web:a142528e85468320050837',
    messagingSenderId: '280548092182',
    projectId: 'easy-patient',
    authDomain: 'easy-patient.firebaseapp.com',
    storageBucket: 'easy-patient.appspot.com',
    measurementId: 'G-C4ZWGTL2CE',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCa3yJeUr_yaUsth5EPmCfNoJa5jUddDXQ',
    appId: '1:280548092182:android:15bb998f4717f120050837',
    messagingSenderId: '280548092182',
    projectId: 'easy-patient',
    storageBucket: 'easy-patient.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDeNMx0ZedzqFzdvQV29Fz76WaCALjtYp4',
    appId: '1:280548092182:ios:9d18d6bf81522833050837',
    messagingSenderId: '280548092182',
    projectId: 'easy-patient',
    storageBucket: 'easy-patient.appspot.com',
    iosClientId: '280548092182-lb4hqf6bk77ihb7cqefssdj2ijbisbiq.apps.googleusercontent.com',
    iosBundleId: 'com.example.easyPatient',
  );
}
