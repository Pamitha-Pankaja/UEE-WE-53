import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(MaterialApp(
    home: ShowAgriStatistic(),
  ));
}

class ShowAgriStatistic extends StatefulWidget {
  @override
  _ShowAgriStatisticState createState() => _ShowAgriStatisticState();
}

class _ShowAgriStatisticState extends State<ShowAgriStatistic> {
  double fem = 1.0; // Adjust this value as needed

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("කෘෂිකාර්මික සංඛ්‍යාලේඛන"),
        backgroundColor: const Color.fromARGB(255, 42, 175, 46),
      ),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.all(20),
            child: Container(
              width: 400 * fem,
              height: 117 * fem,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20 * fem),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x23000000),
                    offset: Offset(0 * fem, 4 * fem),
                    blurRadius: 4 * fem,
                  ),
                ],
              ),
              child: Container(
                padding: EdgeInsets.all(20),
                width: 375.63 * fem,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xfff5f5f5),
                  borderRadius: BorderRadius.circular(20 * fem),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x3f000000),
                      offset: Offset(0 * fem, 4 * fem),
                      blurRadius: 10 * fem,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 20 * fem, right: 20 * fem),
                      child: SvgPicture.asset(
                        'assets/🦆 icon _vegetables_.svg',
                        width: 86.37 * fem,
                        height: 80 * fem,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'බෝග වර්ගය',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 28,
                              fontFamily: 'Iskoola Pota',
                              fontWeight: FontWeight.w400,
                              height: 1.2,
                            ),
                          ),
                          Text(
                            'වට්ටක්කා',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 26,
                              fontFamily: 'Iskoola Pota',
                              fontWeight: FontWeight.w400,
                              height: 1.2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Card(
            margin: EdgeInsets.all(20),
            child: Container(
              width: 400 * fem,
              height: 117 * fem,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20 * fem),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x23000000),
                    offset: Offset(0 * fem, 4 * fem),
                    blurRadius: 4 * fem,
                  ),
                ],
              ),
              child: Container(
                padding: EdgeInsets.all(20),
                width: 375.63 * fem,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xfff5f5f5),
                  borderRadius: BorderRadius.circular(20 * fem),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x3f000000),
                      offset: Offset(0 * fem, 4 * fem),
                      blurRadius: 10 * fem,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start, // Align text to the left
                        children: [
                          Text(
                            'මුළු ගොවීන්',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 28,
                              fontFamily: 'Iskoola Pota',
                              fontWeight: FontWeight.w400,
                              height: 1.2,
                            ),
                          ),
                          Text(
                            '1500',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 26,
                              fontFamily: 'Iskoola Pota',
                              fontWeight: FontWeight.w400,
                              height: 1.2,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20 * fem, right: 20 * fem),
                      child: Image.asset(
                        'assets/farmer.png', // Replace 'your_image.png' with the path to your PNG image
                        width: 86.37 * fem,
                        height: 80 * fem,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Card(
            margin: EdgeInsets.all(20),
            child: Container(
              width: 400 * fem,
              height: 117 * fem,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20 * fem),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x23000000),
                    offset: Offset(0 * fem, 4 * fem),
                    blurRadius: 4 * fem,
                  ),
                ],
              ),
              child: Container(
                padding: EdgeInsets.all(20),
                width: 375.63 * fem,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xfff5f5f5),
                  borderRadius: BorderRadius.circular(20 * fem),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x3f000000),
                      offset: Offset(0 * fem, 4 * fem),
                      blurRadius: 10 * fem,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 20 * fem, right: 20 * fem),
                      child: SvgPicture.asset(
                        'assets/Group.svg',
                        width: 86.37 * fem,
                        height: 80 * fem,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'මුළු අක්කර',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 28,
                              fontFamily: 'Iskoola Pota',
                              fontWeight: FontWeight.w400,
                              height: 1.2,
                            ),
                          ),
                          Text(
                            '2000',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 26,
                              fontFamily: 'Iskoola Pota',
                              fontWeight: FontWeight.w400,
                              height: 1.2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Card(
            margin: EdgeInsets.all(20),
            child: Container(
              width: 400 * fem,
              height: 150 * fem,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20 * fem),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x23000000),
                    offset: Offset(0 * fem, 4 * fem),
                    blurRadius: 4 * fem,
                  ),
                ],
              ),
              child: Container(
                padding: EdgeInsets.all(20),
                width: 375.63 * fem,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xfff5f5f5),
                  borderRadius: BorderRadius.circular(20 * fem),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x3f000000),
                      offset: Offset(0 * fem, 4 * fem),
                      blurRadius: 10 * fem,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start, // Align text to the left
                        children: [
                          Text(
                            'ඇස්තමේන්තුගත අස්වැන්න',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                              fontFamily: 'Iskoola Pota',
                              fontWeight: FontWeight.w400,
                              height: 1.2,
                            ),
                          ),
                          Text(
                            '1500000Kg',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                              fontFamily: 'Iskoola Pota',
                              fontWeight: FontWeight.w400,
                              height: 1.2,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20 * fem, right: 20 * fem),
                      child: SvgPicture.asset(
                        'assets/🦆 icon _paddy_.svg',
                        width: 86.37 * fem,
                        height: 80 * fem,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                const Color.fromARGB(255, 42, 175, 46),
              ),
              minimumSize: MaterialStateProperty.all<Size>(Size(170, 50)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
            ),
            onPressed: () {
              // Handle button press
            },
            child: Text(
              'ආපසු',
              style: TextStyle(fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }
}
