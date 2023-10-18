import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:device_preview/device_preview.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyAFXVAKjzwyeemlNMEggRLRCJNuhrDxXrs", // Updated apiKey
      authDomain: "uee-we-53.firebaseapp.com", // Updated authDomain
      projectId: "uee-we-53", // Updated projectId
      storageBucket: "uee-we-53.appspot.com", // Updated storageBucket
      messagingSenderId: "627858556749", // Update with your messagingSenderId
      appId: "1:428332350161:android:e38f4830934c301c0023f0", // Updated appId
    ),
  );
  runApp(
    DevicePreview(
      builder: (context) => MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
    );
  }
}


