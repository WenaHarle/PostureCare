import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: "AIzaSyBggelmMnCqJErmqzKJPvie3U_gKnXT6W8",
    authDomain: "postucare-c8f3b.firebaseapp.com",
    databaseURL: "https://postucare-c8f3b-default-rtdb.firebaseio.com",
    projectId: "postucare-c8f3b",
    storageBucket: "postucare-c8f3b.appspot.com",
    messagingSenderId: "103054121848",
    appId: "1:103054121848:web:16eb169cf0ce405ccc868d",
    measurementId: "G-3LB4HBXZ3L"
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: "AIzaSyBggelmMnCqJErmqzKJPvie3U_gKnXT6W8",
    authDomain: "postucare-c8f3b.firebaseapp.com",
    databaseURL: "https://postucare-c8f3b-default-rtdb.firebaseio.com",
    projectId: "postucare-c8f3b",
    storageBucket: "postucare-c8f3b.appspot.com",
    messagingSenderId: "103054121848",
    appId: "1:103054121848:web:16eb169cf0ce405ccc868d",
    measurementId: "G-3LB4HBXZ3L"
  );
}

