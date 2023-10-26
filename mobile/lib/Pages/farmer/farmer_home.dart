import 'package:flutter/material.dart';
import 'package:mobile/Pages/farmer/my_harvest.dart';
import 'package:mobile/Pages/farmer/publish_harvest.dart';
import 'package:mobile/Services/FarmerServices/farmer_profile_services.dart';

class FarmerHome extends StatefulWidget {
  final Map<String, dynamic> userData;
  const FarmerHome({Key? key, required this.userData}) : super(key: key);

  @override
  State<FarmerHome> createState() => _FarmerHomeState();
}

class _FarmerHomeState extends State<FarmerHome> {

  Map<String, dynamic> userProfile = Map<String, dynamic>(); // Initialize userData

  @override
  void initState() {
    super.initState();
    // Call the getUserProfile method to get user data
    FarmerProfileService().getUserProfile().then((data) {
      setState(() {
        userProfile = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Align(
                child: SizedBox(
                  width: 434,
                  height: 220,
                  child: Image.asset(
                    "assets/home.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: SizedBox(
                  width: 278,
                  height: 520,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment(-1, -0.107),
                        end: Alignment(1, -0.097),
                        colors: <Color>[Color(0x6d005e2f), Color(0x6d80b027)],
                        stops: <double>[0, 1],
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 60),
                      child: ListView(
                        children: <Widget>[
                          TextWithDivider('බෝග සංඛ්‍යාලේකන', () {
                            // Handle click on Text 1
                          }),
                          TextWithDivider('බෝග පළ කරන්න', () {
                            // Handle click on Text 2
                          }),
                          TextWithDivider('මගේ බෝග', () {
                            // Handle click on Text 3
                          }),
                          TextWithDivider('අස්වැන්න පළ කරන්න', () {
                            Navigator.push(context,MaterialPageRoute(builder: (context) => PublishHarvest(userData: widget.userData,),),);
                          }),
                          TextWithDivider('මගේ අස්වැන්න', () {
                             Navigator.push(context,MaterialPageRoute(builder: (context) => MyHarvest(userData: widget.userData,),),);
                          }),
                          TextWithDivider('නව දේපල', () {
                            // Handle click on Text 6
                          }),
                          TextWithDivider('මගේ දේපල', () {
                            // Handle click on Text 6
                          }),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: 180,
            left: 50,
            child: Center(
              child: Container(
                padding: EdgeInsets.fromLTRB(51, 85, 7, 10),
                width: 297,
                height: 126,
                decoration: BoxDecoration(
                  color: Color(0x99ffffff),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x3f0d1e00),
                      offset: Offset(0, 4),
                      blurRadius: 4,
                    ),
                  ],
                ),
                child: Text(
                  'ආයුබෝවන් ${userProfile['farmerName']}!',
                ),
              ),
            ),
          ),
          Positioned(
            top: 108,
            left: 125,
            child: Container(
              height: 130,
              width: 130,
              margin: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: ClipOval(
                child: Image.network(
                  userProfile['profileImageURL']?? '',
                  width: 150,
                  height: 150,
                  scale: 1.0,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TextWithDivider extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  TextWithDivider(this.text, this.onTap);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 8),
            child: Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
        ),
        Divider(
          color: Colors.white,
        ),
      ],
    );
  }
}
