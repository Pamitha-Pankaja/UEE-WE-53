import 'package:flutter/material.dart';
import 'ShowIrrigationstat.dart';
import 'FillAllFieldDialog.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SelectIrrigationstat(),
    );
  }
}

class SelectIrrigationstat extends StatefulWidget {
  @override
  _SelectIrrigationstatState createState() => _SelectIrrigationstatState();
}

class _SelectIrrigationstatState extends State<SelectIrrigationstat> {
  double fem = 1.0; // Adjust this value as needed
  String? selecteddistrict;
  String? selectedwatercomingmethod;
  String? selectedmainirrigationarea;
  String? selectedsubirrigationarea;

  bool areDropdownsEmpty() {
    return selecteddistrict == null &&
        selectedwatercomingmethod == null &&
        selectedmainirrigationarea == null &&
        selectedsubirrigationarea == null;
  }

  List<String> distric = [
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
        title: Text("වාරිමාර්ග සංඛ්‍යාලේඛන"),
        backgroundColor: const Color.fromARGB(255, 42, 175, 46),
      ),
      body: Column(
        children: <Widget>[
          // Static image container placed outside the scrolling area
          Container(
            padding:
                EdgeInsets.fromLTRB(15 * fem, 9 * fem, 16 * fem, 144 * fem),
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                    "assets/3.png"), // Replace with your image asset path
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Dropdowns and related elements
                  buildDropdownField(selecteddistrict, distric, 'දිස්ත්‍රික්කය',
                      (value) {
                    selecteddistrict = value;
                  }),
                  SizedBox(height: 16),
                  buildDropdownField(
                      selectedwatercomingmethod, watermethods, 'ජල මූලාශ්‍රය',
                      (value) {
                    selectedwatercomingmethod = value;
                  }),
                  SizedBox(height: 16),
                  buildDropdownField(selectedmainirrigationarea,
                      mainirrigationarea, 'ප්‍රදාන වාරිමාර්ග කලාපය', (value) {
                    selectedmainirrigationarea = value;
                  }),
                  SizedBox(height: 16),
                  buildDropdownField(selectedsubirrigationarea,
                      subirrigationarea, 'උප වාරිමාර්ග කලාපය', (value) {
                    selectedsubirrigationarea = value;
                  }),
                  SizedBox(height: 16),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        if (areDropdownsEmpty()) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return FillAllFieldDialog();
                            },
                          );
                        } else {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ShowIrrigationstat(
                                selecteddistrict: selecteddistrict,
                                selectedwatercomingmethod:
                                    selectedwatercomingmethod,
                                selectedmainirrigationarea:
                                    selectedmainirrigationarea,
                                selectedsubirrigationarea:
                                    selectedsubirrigationarea,
                              ),
                            ),
                          );
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          const Color.fromARGB(255, 42, 175, 46),
                        ),
                        minimumSize:
                            MaterialStateProperty.all<Size>(Size(170, 50)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                      ),
                      child: Text(
                        'පෙන්වන්න',
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDropdownField(String? selectedValue, List<String> items,
      String labelText, void Function(String?) onChanged) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 10, bottom: 16.0), // Add 10 left margin
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            labelText,
            style: TextStyle(
              fontSize: 16.0,
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
}
