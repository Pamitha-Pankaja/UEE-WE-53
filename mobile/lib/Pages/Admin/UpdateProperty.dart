import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UpdateProperty extends StatefulWidget {
  final String documentId;

  UpdateProperty({required this.documentId});

  @override
  _UpdatePropertyState createState() => _UpdatePropertyState();
}

class _UpdatePropertyState extends State<UpdateProperty> {
  TextEditingController areaController = TextEditingController();
  TextEditingController commentController = TextEditingController();
  TextEditingController propertynameController = TextEditingController();
  TextEditingController ownernameController = TextEditingController();

  String? selectedprovince;
  String? selecteddistrict;
  String? selectedsecreterydivision;
  String? selectedagriculturedivision;
  String? selectedwatercomingmethod;
  String? selectedmainirrigationarea;
  String? selectedsubirrigationarea;

  List<String> province = [
    "උතුරු පළාත",
    "වයඹ පළාත",
    "බස්නාහිර පළාත",
    "උතුරු මැද පළාත",
    "මධ්‍යම පළාත",
    "සබරගමුව පළාත",
    "නැගෙනහිර පළාත",
    "ඌව පළාත",
    "දකුණු පළාත"
  ];

  List<String> distric = [
    "යාපනය",
    "කිලිනොච්චි",
    "මන්නාරම",
    "මුලතිව්",
    "වවුනියාව",
    "පුත්තලම",
    "කුරුණෑගල",
    " ගම්පහ",
    "කොළඹ",
    "කළුතර",
    "අනුරාධපුර",
    "පොලොන්නරුව",
    "මාතලේ",
    "මහනුවර",
    "නුවරඑලිය",
    "කෑගල්ල",
    "රත්නපුර",
    "ත්‍රිකුණාමලය",
    "මඩකලපුව",
    " අම්පාර",
    "බදුල්ල",
    "මොණරාගල",
    "හම්බන්තොට",
    "මාතර",
    "ගාල්ල"
  ];

  List<String> secreterydivision = [
    "බඩල්කුඹුර",
    "බිබිල",
    "බුත්තල",
    "කතරගම",
    "මඩුල්ල-දඹගල්ල",
    "මැදගම ",
    "මොණරාගල",
    "සෙවනගල",
    "සියඹලාණ්ඩුව",
    "තණමල්විල",
    "වැල්ලවාය"
  ];

  List<String> agriculturedivision = [
    "තෙලුල්ල",
    "ඇතිලිවැව",
    "මහාආර ගම",
    "රන්දෙනිගොඩයාය",
    "වෙහෙරයාය",
    "සිරිපුරගම",
    "බලහරුව",
    "කිතුල්කොටේ",
  ];

  List<String> watermethods = [
    "ඇළ මාර්ග",
    "ගංගා",
    "අහස්දිය",
    "භූගත ජලය",
    "වැව"
  ];

  List<String> mainirrigationarea = ["බදුල්ල", "බිබිල", "බුත්තල"];
  List<String> subirrigationarea = [
    "මොණරාගල",
    "බුත්තල",
    "තණමල්විල",
    "වැල්ලවාය",
    "සෙවණගල",
    "බඩල්කුඹුර",
    "කතරගම",
    "සියඹලාණ්ඩුව"
  ];

  @override
  void initState() {
    super.initState();
    fetchDataFromFirestore();
  }

  Future<void> fetchDataFromFirestore() async {
    try {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('properties')
          .doc(widget.documentId)
          .get();

      if (documentSnapshot.exists) {
        Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;
        setState(() {
          selectedprovince = data['province'];
          selecteddistrict = data['district'];
          selectedsecreterydivision = data['secreterydivision'];
          selectedagriculturedivision = data['agriculturedivision'];
          propertynameController.text = data['propertyname'];
          ownernameController.text = data['ownername'];
          selectedwatercomingmethod = data['watercomingmethod'];
          selectedmainirrigationarea = data['mainirrigationarea'];
          selectedsubirrigationarea = data['subirrigationarea'];
          areaController.text = data['area'].toString();
          commentController.text = data['comment'];
        });
      } else {
        print('Document does not exist.');
      }
    } catch (e) {
      print("Error fetching data from Firestore: $e");
    }
  }

  Future<void> updateFirestoreDocument() async {
    try {
      final DocumentReference docRef = FirebaseFirestore.instance
          .collection('properties')
          .doc(widget.documentId);
      await docRef.update({
        'province': selectedprovince,
        'district': selecteddistrict,
        'secreterydivision': selectedsecreterydivision,
        'agriculturedivision': selectedagriculturedivision,
        'propertyname': propertynameController.text,
        'ownername': ownernameController.text,
        'watercomingmethod': selectedwatercomingmethod,
        'mainirrigationarea': selectedmainirrigationarea,
        'subirrigationarea': selectedsubirrigationarea,
        'area':
            int.parse(areaController.text), // Convert the area to an integer
        'comment': commentController.text,
      });
      // Print a success message or handle the update completion as needed.
      print('Document updated successfully');
    } catch (e) {
      // Handle any errors that occur during the update.
      print("Error updating data in Firestore: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("දේපල යාවත්කාලීන කිරඓම"),
        backgroundColor: const Color.fromARGB(255, 42, 175, 46),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildDropdownField(selectedprovince, province, 'පලාත'),
            buildDropdownField(selecteddistrict, distric, 'දිස්ත්‍රික්කය'),
            buildDropdownField(selectedsecreterydivision, secreterydivision,
                'ප්‍රාදේශීය ලේකම් කොට්ඨාසය'),
            buildDropdownField(selectedagriculturedivision, agriculturedivision,
                'කෘෂිකර්ම සේවා අංශය'),
            buildInputField(propertynameController, 'දේපල නම'),
            buildInputField(ownernameController, 'අයිතිකරුගේ නම'),
            buildDropdownField(
                selectedwatercomingmethod, watermethods, 'ජල මූලාශ්‍රය'),
            buildDropdownField(selectedmainirrigationarea, mainirrigationarea,
                'ප්‍රදාන වාරිමාර්ග කලාපය'),
            buildDropdownField(selectedsubirrigationarea, subirrigationarea,
                'උප වාරිමාර්ග කලාපය'),
            buildInputField(areaController, 'භූමි ප්‍රමාණය(අක්කර)'),
            buildInputField(commentController, 'සටහන්'),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Handle form submission
                  String province = selectedprovince ?? '';
                  String district = selecteddistrict ?? '';
                  String secreterydivision = selectedsecreterydivision ?? '';
                  String area = areaController.text;
                  String comment = commentController.text;
                  String agriculturedivision =
                      selectedagriculturedivision ?? '';
                  String propertyname = propertynameController.text;
                  String ownername = ownernameController.text;
                  String watercomingmethod = selectedwatercomingmethod ?? '';
                  String mainirrigationarea = selectedmainirrigationarea ?? '';
                  String subirrigationarea = selectedsubirrigationarea ?? '';

                  // Process the data or make API calls as needed

                  updateFirestoreDocument();
                },
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
                child: Text(
                  'ඇතුළත් කරන්න',
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDropdownField(
    String? selectedValue,
    List<String> items,
    String labelText,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            labelText,
            style: TextStyle(
              fontSize: 13.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(1.0),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: DropdownButtonFormField<String>(
                value: selectedValue,
                onChanged: (newValue) {
                  setState(() {
                    selectedValue = newValue;
                  });
                },
                items: items.map((item) {
                  return DropdownMenuItem(
                    value: item,
                    child: Text(item),
                  );
                }).toList(),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(16.0),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildInputField(
    TextEditingController controller,
    String labelText,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            labelText,
            style: TextStyle(
              fontSize: 13.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: TextFormField(
                controller: controller,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(16.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
