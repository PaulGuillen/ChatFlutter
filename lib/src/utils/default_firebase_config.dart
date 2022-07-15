import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

class DefaultFirebaseConfig {
  static FirebaseOptions get platformOptions {
    if (kIsWeb) {
      // Web
      return const FirebaseOptions(
        apiKey: 'AIzaSyAgUhHU8wSJgO5MVNy95tMT07NEjzMOfz0',
        authDomain: 'react-native-firebase-testing.firebaseapp.com',
        databaseURL: 'https://react-native-firebase-testing.firebaseio.com',
        projectId: 'flutterchat-7733a',
        storageBucket: 'react-native-firebase-testing.appspot.com',
        messagingSenderId: '448618578101',
        appId: '1:448618578101:web:772d484dc9eb15e9ac3efc',
        measurementId: 'G-0N1G9FLDZE',
      );
    } else if (Platform.isIOS || Platform.isMacOS) {
      // iOS and MacOS
      return const FirebaseOptions(
        apiKey: 'AIzaSyAHAsf51D0A407EklG1bs-5wA7EbyfNFg0',
        appId: '1:448618578101:ios:0b11ed8263232715ac3efc',
        messagingSenderId: '448618578101',
        projectId: 'flutterchat-7733a',
        authDomain: 'react-native-firebase-testing.firebaseapp.com',
        iosBundleId: 'io.flutter.plugins.firebase.messaging',
        iosClientId:
        '448618578101-evbjdqq9co9v29pi8jcua8bm7kr4smuu.apps.googleusercontent.com',
        databaseURL: 'https://react-native-firebase-testing.firebaseio.com',
      );
    } else {
      // Android
      return const FirebaseOptions(
        appId: '1:583482011417:android:175bddb2eeca9dae05df88',
        apiKey: 'AIzaSyBJYUFaJAUoMcviyjnrml9PslaKu-0ifMc',
        projectId: 'flutterchat-7733a',
        messagingSenderId: '583482011417',
        authDomain: 'flutterchat-7733a.appspot.com',
        androidClientId:
        '583482011417-1ff3ou44mn7kcovk7uqvjeoitd82odag.apps.googleusercontent.com',
      );
    }
  }
}