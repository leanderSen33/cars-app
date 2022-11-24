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
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCUgdQVlKUB9xwlz0jZRPEuahTszjaPi_c',
    appId: '1:692855397468:android:0c476baf2f3cad73bf1a99',
    messagingSenderId: '692855397468',
    projectId: 'cos-challenge',
    storageBucket: 'cos-challenge.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBKIV0bnWuqe3uV4htLVJJHK6sdQGPtr28',
    appId: '1:692855397468:ios:e5cdb6e5e0f6d2d4bf1a99',
    messagingSenderId: '692855397468',
    projectId: 'cos-challenge',
    storageBucket: 'cos-challenge.appspot.com',
    iosClientId:
        '692855397468-5dprfmq9d93hqmcqda18ddacfuve3hmc.apps.googleusercontent.com',
    iosBundleId: 'com.leocosie.cars_app',
  );
}
