import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'DataNotfoundDialog1.dart';

class ShowIrrigationstat extends StatefulWidget {
  final String? selecteddistrict;
  final String? selectedwatercomingmethod;
  final String? selectedmainirrigationarea;
  final String? selectedsubirrigationarea;

  ShowIrrigationstat({
    this.selecteddistrict,
    this.selectedwatercomingmethod,
    this.selectedmainirrigationarea,
    this.selectedsubirrigationarea,
  });

  @override
  _ShowIrrigationstatState createState() => _ShowIrrigationstatState();
}

class _ShowIrrigationstatState extends State<ShowIrrigationstat> {
  double fem = 1.0; // Adjust this value as needed
  String totalfarmers = '';
  String totalarea = '';

  String? district;
  String? watercomingmethod;
  String? mainirrigationarea;
  String? subirrigationarea;

  @override
  void initState() {
    super.initState();
    district = widget.selecteddistrict;
    watercomingmethod = widget.selectedwatercomingmethod;
    mainirrigationarea = widget.selectedmainirrigationarea;
    subirrigationarea = widget.selectedsubirrigationarea;

    fetchDatafromFirebase();
  }

  Future<void> fetchDatafromFirebase() async {
    // Fetch data from firebase
    // Set totalfarmers and totalarea
    double totalArea = 0;
    int totalFarmers = 0;
    final firestore = FirebaseFirestore.instance;

    final query = firestore
        .collection("crops")
        .where("waterSource", isEqualTo: watercomingmethod)
        .where("mainIrrigationArea", isEqualTo: mainirrigationarea)
        .where("subIrrigationArea", isEqualTo: subirrigationarea);

    final querySnapshot = await query.get();

    for (final doc in querySnapshot.docs) {
      final data = doc.data() as Map<String, dynamic>;
      final area = double.tryParse(data['area'] ?? '0') ?? 0.0;

      totalArea += area;
      totalFarmers++;
    }

    if (totalFarmers == 0) {
      showDataNotFoundDialog();
      totalFarmers = 0;
      print("Total Farmers: $totalFarmers");
    }

    setState(() {
      totalarea = totalArea.toStringAsFixed(2);
      totalfarmers = totalFarmers.toString();
    });
  }

  void showDataNotFoundDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return DataNotFoundDialog1();
      },
    );
  }

  Widget build(BuildContext context) {
    print("Selected District: ${widget.selecteddistrict}");
    print(
        "Selected Water Coming Method: ${widget.selectedwatercomingmethod ?? "null"}");
    print(
        "Selected Main Irrigation Area: ${widget.selectedmainirrigationarea ?? "null"}");
    print(
        "Selected Sub Irrigation Area: ${widget.selectedsubirrigationarea ?? "null"}");

    return Scaffold(
      appBar: AppBar(
        title: Text("වාරිමාර්ග සංඛ්‍යාලේඛන"),
        backgroundColor: Color.fromARGB(255, 1, 130, 65),
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
                            'ජල මූලාශ්‍රය',
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
                            widget.selectedwatercomingmethod ?? "null",
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
                            totalfarmers,
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
                            totalarea,
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
              height: 122 * fem,
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
                            'වාරිමාර්ග කලාපය',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 21,
                              fontFamily: 'Iskoola Pota',
                              fontWeight: FontWeight.w400,
                              height: 1.2,
                            ),
                          ),
                          Text(
                            widget.selectedsubirrigationarea ?? "null",
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
                        'assets/lake.png', // Replace 'your_image.png' with the path to your PNG image
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
