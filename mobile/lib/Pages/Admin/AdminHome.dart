import 'package:flutter/material.dart';
import 'AdminCropStaristic.dart';
import 'SelectIrrigationstat.dart';

class AdminHome extends StatefulWidget {
  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  Map<String, dynamic> userProfile =
      Map<String, dynamic>(); // Initialize userData

  @override
  void initState() {
    super.initState();
    // Call the getUserProfile method to get user data
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
                  height: MediaQuery.of(context).size.height - 220,
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
                      padding: const EdgeInsets.only(top: 100),
                      child: ListView(
                        children: <Widget>[
                          TextWithDivider('බෝග සංඛ්‍යාලේකන', () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AdminCropStaristic(),
                              ),
                            );
                          }),
                          TextWithDivider('වාරිමාර්ග සංඛ්‍යාලේකන', () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SelectIrrigationstat(),
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
                child: Center(
                  child: Text(
                    'ආයුබෝවන්',
                    style: TextStyle(
                      color: Colors.black, // You can set the desired text color
                      fontSize: 24, // Adjust the font size as needed
                      fontWeight: FontWeight.bold, // Make the text bold
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
                child: Image.asset(
                  'assets/adminlogo.png',
                  width: 150,
                  height: 150,
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
