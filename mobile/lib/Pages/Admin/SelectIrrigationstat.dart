import 'package:flutter/material.dart';



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

  List<String> distric = [
    // Districts list...
  ];

  List<String> watermethods = [
    // Water methods list...
  ];

  List<String> mainirrigationarea = [
    // Main irrigation areas list...
  ];

  List<String> subirrigationarea = [
    // Sub irrigation areas list...
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
                  buildDropdownField(
                      selecteddistrict, distric, 'දිස්ත්‍රික්කය'),
                  SizedBox(height: 16),
                  buildDropdownField(
                      selectedwatercomingmethod, watermethods, 'ජල මූලාශ්‍රය'),
                  SizedBox(height: 16),
                  buildDropdownField(selectedmainirrigationarea,
                      mainirrigationarea, 'ප්‍රදාන වාරිමාර්ග කලාපය'),
                  SizedBox(height: 16),
                  buildDropdownField(selectedsubirrigationarea,
                      subirrigationarea, 'උප වාරිමාර්ග කලාපය'),
                  SizedBox(height: 16),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        // Handle form submission

                        String district = selecteddistrict ?? '';

                        String watercomingmethod =
                            selectedwatercomingmethod ?? '';
                        String mainirrigationarea =
                            selectedmainirrigationarea ?? '';
                        String subirrigationarea =
                            selectedsubirrigationarea ?? '';

                        // Process the data or make API calls as needed

                        print('Agriculture Property: $district');
                        print('Water Coming Method: $watercomingmethod');
                        print('Main Irrigation Area: $mainirrigationarea');
                        print('Sub Irrigation Area: $subirrigationarea');
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
                        'Show',
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

  Widget buildDropdownField(
      String? selectedValue, List<String> items, String labelText) {
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
}
