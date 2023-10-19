import 'package:flutter/material.dart';

class UpdateProperty extends StatefulWidget {
  const UpdateProperty({Key? key}) : super(key: key);

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("දේපල යාවත්කාලීන කිරීම"),
        backgroundColor: const Color.fromARGB(255, 42, 175, 46),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50),
            buildDropdownField(selectedprovince, province, 'පලාත'),
            SizedBox(height: 16),
            buildDropdownField(selecteddistrict, distric, 'දිස්ත්‍රික්කය'),
            SizedBox(height: 16),
            buildDropdownField(selectedsecreterydivision, secreterydivision,
                'ප්‍රාදේශීය ලේකම් කොට්ඨාසය'),
            SizedBox(height: 16),
            buildDropdownField(selectedagriculturedivision, agriculturedivision,
                'කෘෂිකර්ම සේවා අංශය'),
            SizedBox(height: 16),
            buildInputField(propertynameController, 'දේපල නම'),
            SizedBox(height: 16),
            buildInputField(ownernameController, 'අයිතිකරුගේ නම'),
            SizedBox(height: 16),
            buildDropdownField(
                selectedwatercomingmethod, watermethods, 'ජල මූලාශ්‍රය'),
            SizedBox(height: 16),
            buildDropdownField(selectedmainirrigationarea, mainirrigationarea,
                'ප්‍රදාන වාරිමාර්ග කලාපය'),
            SizedBox(height: 16),
            buildDropdownField(selectedsubirrigationarea, subirrigationarea,
                'උප වාරිමාර්ග කලාපය'),
            SizedBox(height: 16),
            buildInputField(areaController, 'භූමි ප්‍රමාණය(අක්කර)'),
            SizedBox(height: 16),
            buildInputField(commentController, 'සටහන්'),
            SizedBox(height: 16),
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
                  print('Crop Type: $province');
                  print('Agriculture Property: $district');
                  print('Water Source: $secreterydivision');
                  print('Area: $area');
                  print('Expected Harvest: $comment');
                  print('Agriculture Division: $agriculturedivision');
                  print('Property Name: $propertyname');
                  print('Owner Name: $ownername');
                  print('Water Coming Method: $watercomingmethod');
                  print('Main Irrigation Area: $mainirrigationarea');
                  print('Sub Irrigation Area: $subirrigationarea');
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

void main() {
  runApp(MaterialApp(
    home: UpdateProperty(),
  ));
}
