import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'DataNotfoundDialog.dart';

class ShowAgriStatistic extends StatefulWidget {
  final String selectedRegion;
  final String? selectedProvince;
  final String? selectedDistrict;
  final String? selectedDivisionalSecretary;
  final String? selectedCropType;

  ShowAgriStatistic({
    required this.selectedRegion,
    this.selectedProvince,
    this.selectedDistrict,
    this.selectedDivisionalSecretary,
    this.selectedCropType,
  });

  @override
  _ShowAgriStatisticState createState() => _ShowAgriStatisticState();
}

class _ShowAgriStatisticState extends State<ShowAgriStatistic> {
  double fem = 1.0; // Adjust this value as needed
  String totalfarmers = "";
  String totalarea = "";
  String estimateharvest = "";

  String? district;
  String? cropType;
  String? province;
  String? divisionalSecretary;
  String? region;

  @override
  void initState() {
    super.initState();

    district = widget.selectedDistrict;
    cropType = widget.selectedCropType;
    province = widget.selectedProvince;
    divisionalSecretary = widget.selectedDivisionalSecretary;
    region = widget.selectedRegion;

    fetchDataFromFirestore();
    // Set the values based on the selectedCropType
  }

  Future<void> fetchDataFromFirestore() async {
    double totalArea = 0.0;
    double totalHarvest = 0.0;
    int totalFarmers = 0;
    final firestore = FirebaseFirestore.instance;

    if (region == 'Province') {
      final query = firestore
          .collection('crops')
          .where('cropType', isEqualTo: cropType)
          .where('province', isEqualTo: province);

      final querySnapshot = await query.get();

      for (final doc in querySnapshot.docs) {
        final data = doc.data() as Map<String, dynamic>;
        final area = double.tryParse(data['area'] ?? '0') ?? 0.0;
        final harvest = double.tryParse(data['expectedHarvest'] ?? '0') ?? 0.0;

        totalArea += area;
        totalHarvest += harvest;
        totalFarmers++;
      }
    } else if (region == 'District') {
      final query = firestore
          .collection('crops')
          .where('cropType', isEqualTo: cropType)
          .where('district', isEqualTo: district);

      final querySnapshot = await query.get();

      for (final doc in querySnapshot.docs) {
        final data = doc.data() as Map<String, dynamic>;
        final area = double.tryParse(data['area'] ?? '0') ?? 0.0;
        final harvest = double.tryParse(data['expectedHarvest'] ?? '0') ?? 0.0;

        totalArea += area;
        totalHarvest += harvest;
        totalFarmers++;
      }
    } else if (region == 'Divisional Secretary') {
      final query = firestore
          .collection('crops')
          .where('cropType', isEqualTo: cropType)
          .where('secretaryDivision', isEqualTo: divisionalSecretary);

      final querySnapshot = await query.get();

      for (final doc in querySnapshot.docs) {
        final data = doc.data() as Map<String, dynamic>;
        final area = double.tryParse(data['area'] ?? '0') ?? 0.0;
        final harvest = double.tryParse(data['expectedHarvest'] ?? '0') ?? 0.0;

        totalArea += area;
        totalHarvest += harvest;
        totalFarmers++;
      }
    } else if (region == 'Sri Lanka') {
      final query =
          firestore.collection('crops').where('cropType', isEqualTo: cropType);

      final querySnapshot = await query.get();

      for (final doc in querySnapshot.docs) {
        final data = doc.data() as Map<String, dynamic>;
        final area = double.tryParse(data['area'] ?? '0') ?? 0.0;
        final harvest = double.tryParse(data['expectedHarvest'] ?? '0') ?? 0.0;

        totalArea += area;
        totalHarvest += harvest;
        totalFarmers++;
      }
    } else {
      showDataNotFoundDialog();
    }

    print("Total Farmers: $totalFarmers");
    if (totalFarmers == 0) {
      showDataNotFoundDialog();
      totalFarmers = 0;
    }

    if (cropType == 'Not Selected') {
      totalHarvest = 0.0;
    }

    setState(() {
      totalarea = totalArea.toStringAsFixed(2);
      if (cropType == 'Not Selected' || cropType == ' Not Selected') {
        estimateharvest = 'Not Selected';
      } else {
        estimateharvest = totalHarvest.toStringAsFixed(2) + " KG";
      }
      totalfarmers = totalFarmers.toString();
    });
  }

  void showDataNotFoundDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return DataNotFoundDialog();
      },
    );
  }

  Widget build(BuildContext context) {
    print("Selected Region: ${widget.selectedRegion}");
    print("Selected Province: ${widget.selectedProvince ?? 'Not selected'}");
    print("Selected District: ${widget.selectedDistrict ?? 'Not selected'}");
    print(
        "Selected Divisional Secretary: ${widget.selectedDivisionalSecretary ?? 'Not selected'}");
    print("Selected Crop Type: ${widget.selectedCropType ?? 'Not selected'}");
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
                            'භෝග වර්ගය',
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
                            widget.selectedCropType ?? 'Not selected',
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
                            'මුලු ගොවීන්',
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
                            'මුලු අක්කර',
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
                            'ඇස්තමේන්තු අස්වැන්න',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 23,
                              fontFamily: 'Iskoola Pota',
                              fontWeight: FontWeight.w400,
                              height: 1.2,
                            ),
                          ),
                          Text(
                            estimateharvest,
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
