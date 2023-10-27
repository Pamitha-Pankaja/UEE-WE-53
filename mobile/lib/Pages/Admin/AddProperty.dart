import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'FillAllFieldDialog.dart';
import 'package:provider/provider.dart';
import 'package:mobile/Pages/Common/login_page.dart';
import 'DataInsertSuccessfullyDialog.dart';

void main() {
  runApp(MaterialApp(
    home: AddProperty(),
  ));
}

class AddProperty extends StatefulWidget {
  const AddProperty({Key? key}) : super(key: key);

  @override
  _AddPropertyState createState() => _AddPropertyState();
}

class _AddPropertyState extends State<AddProperty> {
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

  String loginEmail = '';

  bool areFieldsEmpty() {
    if (selectedprovince == null ||
        selecteddistrict == null ||
        selectedsecreterydivision == null ||
        selectedagriculturedivision == null ||
        selectedwatercomingmethod == null ||
        selectedmainirrigationarea == null ||
        selectedsubirrigationarea == null ||
        areaController.text.isEmpty ||
        commentController.text.isEmpty ||
        propertynameController.text.isEmpty ||
        ownernameController.text.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
    // Get the email from Provider
    loginEmail = context.read<LoginEmailProvider>().email;
  }

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
  List<String> district = [
    "යාපනය",
    "කිලිනොච්චි",
    "මන්නාරම",
    "මුලතිව්",
    "වවුනියාව",
    "පුත්තලම",
    "කුරුණෑගල",
    "ගම්පහ",
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
    "අම්පාර",
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
    "මැදගම",
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

  void showDataNotFoundDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return DataInsertSuccessfullyDialog();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("දේපල ඇතුළත් කරන්න"),
        backgroundColor: Color.fromARGB(255, 1, 130,65),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50),
            // Build dropdown fields and update selected values using callback functions.
            buildDropdownField(
              selectedprovince,
              province,
              'පලාත',
              (value) {
                setState(() {
                  selectedprovince = value;
                });
              },
            ),
            SizedBox(height: 16),
            buildDropdownField(
              selecteddistrict,
              district,
              'දිස්ත්‍රික්කය',
              (value) {
                setState(() {
                  selecteddistrict = value;
                });
              },
            ),
            SizedBox(height: 16),
            buildDropdownField(
              selectedsecreterydivision,
              secreterydivision,
              'ප්‍රාදේශීය ලේකම් කොට්ඨාසය',
              (value) {
                setState(() {
                  selectedsecreterydivision = value;
                });
              },
            ),
            SizedBox(height: 16),
            buildDropdownField(
              selectedagriculturedivision,
              agriculturedivision,
              'කෘෂිකර්ම සේවා අංශය',
              (value) {
                setState(() {
                  selectedagriculturedivision = value;
                });
              },
            ),
            SizedBox(height: 16),
            buildInputField(propertynameController, 'දේපල නම'),
            SizedBox(height: 16),
            buildInputField(ownernameController, 'අයිතිකරුගේ නම'),
            SizedBox(height: 16),
            buildDropdownField(
              selectedwatercomingmethod,
              watermethods,
              'ජල මූලාශ්‍රය',
              (value) {
                setState(() {
                  selectedwatercomingmethod = value;
                });
              },
            ),
            SizedBox(height: 16),
            buildDropdownField(
              selectedmainirrigationarea,
              mainirrigationarea,
              'ප්‍රදාන වාරිමාර්ග කලාපය',
              (value) {
                setState(() {
                  selectedmainirrigationarea = value;
                });
              },
            ),
            SizedBox(height: 16),
            buildDropdownField(
              selectedsubirrigationarea,
              subirrigationarea,
              'උප වාරිමාර්ග කලාපය',
              (value) {
                setState(() {
                  selectedsubirrigationarea = value;
                });
              },
            ),
            SizedBox(height: 16),
            buildInputField(areaController, 'භූමි ප්‍රමාණය(අක්කර)'),
            
            SizedBox(height: 16),
            buildInputField(commentController, 'සටහන්'),
            SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  // Handle form submission
                  if (areFieldsEmpty()) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return FillAllFieldDialog();
                      },
                    );
                  } else {
                    Map<String, dynamic> propertyData = {
                      'province': selectedprovince ?? '',
                      'district': selecteddistrict ?? '',
                      'secreterydivision': selectedsecreterydivision ?? '',
                      'area': areaController.text,
                      'comment': commentController.text,
                      'agriculturedivision': selectedagriculturedivision ?? '',
                      'propertyname': propertynameController.text,
                      'ownername': ownernameController.text,
                      'watercomingmethod': selectedwatercomingmethod ?? '',
                      'mainirrigationarea': selectedmainirrigationarea ?? '',
                      'subirrigationarea': selectedsubirrigationarea ?? '',
                      'email': loginEmail,
                    };

                    // Process the data or make API calls as needed
                    try {
                      // Reference to your Firestore collection
                      CollectionReference properties =
                          FirebaseFirestore.instance.collection('properties');

                      // Add a new document with a unique ID
                      await properties.add(propertyData);

                      // Data has been saved to Firestore
                      print('Data saved to Firestore');
                      showDataNotFoundDialog();
                    } catch (e) {
                      print('Error saving data to Firestore: $e');
                    }
                  }
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    const Color.fromARGB(255, 42, 175, 46),
                  ),
                  minimumSize: MaterialStateProperty.all<Size>(Size(170, 50)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(15.0), // Set the border radius
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

  // Widget to build dropdown fields
  Widget buildDropdownField(
    String? selectedValue,
    List<String> items,
    String labelText,
    Function(String?) onChanged,
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
                onChanged: onChanged,
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

  // Widget to build input fields
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
