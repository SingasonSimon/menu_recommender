
// lib/firebase_options.dart
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase App.
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
        return web; // Linux uses the Web config usually
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAwgMQ6Du-CuroKwYE89xSu_T9zqQzfBEA',
    appId: '1:1034601838898:web:69d3902096db8a0ff1ff2b',
    messagingSenderId: '1034601838898',
    projectId: 'menu-recommeder',
    authDomain: 'menu-recommeder.firebaseapp.com',
    storageBucket: 'menu-recommeder.firebasestorage.app',
    measurementId: 'G-EMQH3R25ZB',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDirJdcwpJrZsnCnURf6iowc_7JDXk0pZM',
    appId: '1:1034601838898:android:8edbaa68582c419bf1ff2b',
    messagingSenderId: '1034601838898',
    projectId: 'menu-recommeder',
    storageBucket: 'menu-recommeder.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD-lrsSCkLMAx8_tqfv5Q2l4WRXlQSrYYs',
    appId: '1:1034601838898:ios:19f400997ea99ba1f1ff2b',
    messagingSenderId: '1034601838898',
    projectId: 'menu-recommeder',
    storageBucket: 'menu-recommeder.firebasestorage.app',
    iosBundleId: 'com.menuapp.app',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'REPLACE_WITH_YOUR_MACOS_API_KEY',
    appId: 'REPLACE_WITH_YOUR_MACOS_APP_ID',
    messagingSenderId: 'REPLACE_WITH_YOUR_MESSAGING_SENDER_ID',
    projectId: 'REPLACE_WITH_YOUR_PROJECT_ID',
    storageBucket: 'REPLACE_WITH_YOUR_STORAGE_BUCKET',
    iosBundleId: 'com.dimi.menuRecommender',
  );
}
