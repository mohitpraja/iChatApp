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
    apiKey: 'AIzaSyDE6jvgiHL4iKiXV8Cxcdr-xobXgZtiTyo',
    appId: '1:1089248932280:web:e0f8c370e0ef5177ae1f4d',
    messagingSenderId: '1089248932280',
    projectId: 'ichatapp-c94db',
    authDomain: 'ichatapp-c94db.firebaseapp.com',
    storageBucket: 'ichatapp-c94db.appspot.com',
    measurementId: 'G-HYRQBCWJZE',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAItLbGyqtEXeROZ_yaT0NoswCJiGLDjwQ',
    appId: '1:1089248932280:android:a3b4fbb30f5c8308ae1f4d',
    messagingSenderId: '1089248932280',
    projectId: 'ichatapp-c94db',
    storageBucket: 'ichatapp-c94db.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCGPlxQhIpXj9ONdcj5KfH0LXhWV-gXU4A',
    appId: '1:1089248932280:ios:07e82d0a806c8df9ae1f4d',
    messagingSenderId: '1089248932280',
    projectId: 'ichatapp-c94db',
    storageBucket: 'ichatapp-c94db.appspot.com',
    iosClientId: '1089248932280-eifarvfl8ud0fh955k500k7gupp2rtbg.apps.googleusercontent.com',
    iosBundleId: 'com.example.chatapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCGPlxQhIpXj9ONdcj5KfH0LXhWV-gXU4A',
    appId: '1:1089248932280:ios:07e82d0a806c8df9ae1f4d',
    messagingSenderId: '1089248932280',
    projectId: 'ichatapp-c94db',
    storageBucket: 'ichatapp-c94db.appspot.com',
    iosClientId: '1089248932280-eifarvfl8ud0fh955k500k7gupp2rtbg.apps.googleusercontent.com',
    iosBundleId: 'com.example.chatapp',
  );
}
