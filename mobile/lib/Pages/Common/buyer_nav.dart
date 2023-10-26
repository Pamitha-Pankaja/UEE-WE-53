import 'package:flutter/material.dart';
import 'package:mobile/Pages/Buyer/buyer_cart.dart';
import 'package:mobile/Pages/Buyer/buyer_home.dart';
import 'package:mobile/Pages/Buyer/buyer_profile.dart';
import 'package:motion_tab_bar_v2/motion-tab-bar.dart';
import 'package:motion_tab_bar_v2/motion-tab-controller.dart';

class BuyerNavBar extends StatefulWidget {
  final Map<String, dynamic> userData;

  BuyerNavBar({required this.userData});

  @override
  _BuyerNavBarState createState() => _BuyerNavBarState(userData: userData);
}

class _BuyerNavBarState extends State<BuyerNavBar> with TickerProviderStateMixin {
  MotionTabBarController? _motionTabBarController;
  // List<String> selectedItems = []; // Define the selected items list
  final String selectedTypeName ='';
  final String searchTypeName ='';
  final Map<String, dynamic> userData;

  _BuyerNavBarState({required this.userData});

  @override
  void initState() {
    super.initState();

    _motionTabBarController = MotionTabBarController(
      initialIndex: 1,
      length: 3,
      vsync: this,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _motionTabBarController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("UserData: ${widget.userData}");
    return Scaffold(
      bottomNavigationBar: MotionTabBar(
        controller: _motionTabBarController,
        initialSelectedTab: "මුල් පිටුව",
        labels: const ["ගිණුම","මුල් පිටුව","කරත්තය"],
        icons: const [
          Icons.person,
          Icons.home,
          Icons.shopping_cart,
        ],
        badges: [
          null,
          null,
          null,
        ],
        tabSize: 55,
        tabBarHeight: 70,

        textStyle: const TextStyle(
          fontSize: 12,
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
        tabIconColor: Color.fromARGB(255, 0, 0, 0),
        tabIconSize: 28.0,
        tabIconSelectedSize: 26.0,
        tabSelectedColor: Color.fromARGB(255, 255, 255, 255),
        tabIconSelectedColor: const Color.fromARGB(255, 0, 0, 0),
        tabBarColor: Color.fromARGB(255, 1, 130, 65),
        onTabItemSelected: (int value) {
          setState(() {
            _motionTabBarController!.index = value;
          });
        },
      ),
      body: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: _motionTabBarController,
        children: <Widget>[
          BuyerProfile(userData: userData), // Pass userData to Profile Page
          BuyerHome(userData: userData,selectedTypeName:selectedTypeName,searchTypeName: searchTypeName, ), // Pass userData to Home Page
          BuyerCart(userData: userData), // Pass userData to Cart Page
        ],
      ),
    );
  }
}