import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:device_preview/device_preview.dart';
import 'package:mobile/Pages/Buyer/buyer_home.dart';
import 'package:mobile/Pages/Common/buyer_nav.dart';
import 'package:mobile/Pages/Common/farmer_nav.dart';
import 'package:mobile/Pages/Common/first_page.dart';
import 'package:mobile/Pages/Common/login_page.dart';
import 'package:mobile/Pages/Common/signup_page.dart';
import 'package:mobile/Pages/farmer/farmer_home.dart';
import 'package:mobile/Pages/farmer/my_harvest.dart';
import 'package:mobile/Pages/farmer/publish_harvest.dart';

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
 // runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      home: FirstPage(),
      routes: <String, WidgetBuilder>{
         '/buyer_nav':(context) {
          // Retrieve the user data from arguments
          final Map<String, dynamic> userData = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
          return BuyerNavBar(userData: userData);
        },
        '/farmer_nav':(context) {
          // Retrieve the user data from arguments
          final Map<String, dynamic> userData = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
          return FarmerNavBar(userData: userData);
        },
         '/farmer_home': (context) {
          // Retrieve the user data from arguments
          final Map<String, dynamic> userData = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
          return FarmerHome(userData: userData);
        },
         '/buyer_home': (context) {
          // Retrieve the user data from arguments
          final Map<String, dynamic> userData = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
          final String selectedTypeName ='';
          final String searchTypeName ='';
          return BuyerHome(userData: userData,selectedTypeName:selectedTypeName,searchTypeName: searchTypeName,);
        },
        '/publish_harvest': (context) {
          // Retrieve the user data from arguments
          final Map<String, dynamic> userData = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
          return PublishHarvest(userData: userData);
        },
        '/my_harvest': (context) {
          // Retrieve the user data from arguments
          final Map<String, dynamic> userData = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
          return MyHarvest(userData: userData);
        },
         '/signup': (context) => SignupPage(),
         '/login': (context) => LoginPage(),
      }
    );
  }
}


