import 'package:flutter/material.dart';
import 'package:mobile/Components/Farmer/harvestCard.dart';


class MyHarvest extends StatefulWidget {
  final Map<String, dynamic> userData;
  const MyHarvest({Key? key, required this.userData}) : super(key: key);

  @override
  State<MyHarvest> createState() => _MyHarvestState();
}

class _MyHarvestState extends State<MyHarvest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("මගේ අස්වැන්න"),
        backgroundColor: Color(0xFF018241), // Use hexadecimal color format
      ),
      body: Column(
        children: [
          Expanded(
            child: HarvestCard(userData: widget.userData),
          ),
          //FarmerNavigationBar(userData: widget.userData,),
        ],
      ),
    );
  }
}




