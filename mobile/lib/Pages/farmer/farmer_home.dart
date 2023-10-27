import 'package:flutter/material.dart';
import 'package:mobile/Pages/Farmer/cropStatistcs.dart';
import 'package:mobile/Pages/Farmer/myCrops.dart';
import 'package:mobile/Pages/Farmer/publishCrops.dart';
import 'package:mobile/Pages/farmer/my_harvest.dart';
import 'package:mobile/Pages/farmer/publish_harvest.dart';
import 'package:mobile/Services/FarmerServices/farmer_profile_services.dart';
import 'package:mobile/Pages/Admin/ShowMyproperty.dart';
import 'package:mobile/Pages/Admin/AddProperty.dart';

class FarmerHome extends StatefulWidget {
  final Map<String, dynamic> userData;
  const FarmerHome({Key? key, required this.userData}) : super(key: key);

  @override
  State<FarmerHome> createState() => _FarmerHomeState();
}

class _FarmerHomeState extends State<FarmerHome> {
  Map<String, dynamic> userProfile =
      Map<String, dynamic>(); // Initialize userData

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
    var profileImageURL = userProfile['profileImageURL'] ?? '';
    var farmerName = userProfile['farmerName'] ?? '';
    return Scaffold(
      body: SingleChildScrollView( // Wrap your content with a SingleChildScrollView
        child: Stack(
          children: [
            Column(
              children: [
                Align(
                  child: SizedBox(
                    width: 434,
                    height: 200,
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
                    height: MediaQuery.of(context).size.height,
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
                        padding: const EdgeInsets.only(top: 120),
                        child: ListView(
                          children: <Widget>[
                            TextWithDivider('බෝග සංඛ්‍යාලේකන', () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CropStaristic(),
                                ),
                              );
                            }),
                            TextWithDivider('බෝග පළ කරන්න', () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PublishCrops(
                                    userData: widget.userData,
                                  ),
                                ),
                              );
                            }),
                            TextWithDivider('මගේ බෝග', () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MyCrops(
                                    userData: widget.userData,
                                  ),
                                ),
                              );
                            }),
                            TextWithDivider('අස්වැන්න පළ කරන්න', () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PublishHarvest(
                                    userData: widget.userData,
                                  ),
                                ),
                              );
                            }),
                            TextWithDivider('මගේ අස්වැන්න', () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MyHarvest(
                                    userData: widget.userData,
                                  ),
                                ),
                              );
                            }),
                            TextWithDivider('නව දේපල', () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AddProperty(),
                                ),
                              );
                            }),
                            TextWithDivider('මගේ දේපල', () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MyProperty(),
                                ),
                              );
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
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 58.0),
                      child: Text(
                        'ආයුබෝවන් $farmerName!',
                      ),
                    ),
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
                  child: profileImageURL.isNotEmpty
                      ? Image.network(
                          profileImageURL,
                          width: 150,
                          height: 150,
                          scale: 1.0,
                          fit: BoxFit.cover,
                        )
                      : Center(
                          child: Text(
                            farmerName.isNotEmpty ? farmerName[0] : '',
                            style: TextStyle(
                              fontSize: 38.0,
                              color: Color.fromARGB(255, 14, 151, 82),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                ),
              ),
            ),
          ],
        ),
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
