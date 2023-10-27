import 'package:flutter/material.dart';
import 'package:mobile/Pages/farmer/farmer_home.dart';
import 'package:mobile/Pages/farmer/farmer_profile.dart';
import 'package:motion_tab_bar_v2/motion-tab-bar.dart';
import 'package:motion_tab_bar_v2/motion-tab-controller.dart';

class FarmerNavBar extends StatefulWidget {
  final Map<String, dynamic> userData;

  FarmerNavBar({required this.userData});

  @override
  _FarmerNavBarState createState() => _FarmerNavBarState(userData: userData);
}

class _FarmerNavBarState extends State<FarmerNavBar> with TickerProviderStateMixin {
  MotionTabBarController? _motionTabBarController;
  
  final Map<String, dynamic> userData;

  _FarmerNavBarState({required this.userData});

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
    return Scaffold(
      bottomNavigationBar: MotionTabBar(
        controller: _motionTabBarController,
        initialSelectedTab: "මුල් පිටුව",
        labels: const ["ගිණුම","මුල් පිටුව","කරත්තය"],
        icons: const [
          Icons.person,
          Icons.home,
          Icons.question_answer,
        ],
        badges: [
          null,
          null,
          null,
        ],
        tabSize: 65,
        tabBarHeight: 75,
        textStyle: const TextStyle(
          fontSize: 12,
          color: Color.fromARGB(255, 255, 255, 255),
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
          FarmerProfile(userData: userData), // Profile Page
          FarmerHome(userData: userData), // Home Page
          FarmerHome(userData: userData), // Home Page
        ],
      ),
    );
  }
}
