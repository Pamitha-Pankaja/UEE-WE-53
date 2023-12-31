import 'package:flutter/material.dart';
import 'ShowAgriStatistic.dart';

class AdminCropStaristic extends StatefulWidget {
  const AdminCropStaristic({super.key});

  @override
  State<AdminCropStaristic> createState() => _AdminCropStaristicState();
}

class _AdminCropStaristicState extends State<AdminCropStaristic> {
  String selectedRegion = 'Sri Lanka';
  String? selectedProvince;
  String? selectedDistrict;
  String? selectedDivisionalSecretary;
  String? selectedCropType;

  List<String> provinces = [
    "මධ්‍යම පළාත",
    "සබරගමුව පළාත",
    "නැගෙනහිර පළාත",
    "ඌව පළාත",
    "දකුණු පළාත"
  ];
  List<String> districts = [
    "මොණරාගල",
    "බදුල්ල",
  ];
  List<String> divisionalSecretaries = [
    "වැල්ලවාය",
    "බුත්තල",
    "තණමල්විල",
  ];
  List<String> cropTypes = [
    "වී",
    "වට්ටක්කා",
    "මිරිස්",
    "කජු",
    "තක්කාලි",
    "කැරට්",
    "බෝංචි",
    "මාලු මිරිස්",
    "බණ්ඩක්කා",
    "කෙසෙල්",
    "වම්බොටු",
    "පැණිකොමඩු",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("බෝග සංඛ්‍යා ලේකන"),
        backgroundColor: Color.fromARGB(255, 1, 130, 65),
      ),
      body: Column(
        children: [
          Image.asset(
            "assets/2.png",
            height: 300,
            width: 375,
            scale: 1.0,
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, bottom: 12, top: 12),
              child: Column(
                children: [
                  // Image

                  // Form for selecting crop type
                  SizedBox(height: 16),
                  buildDropdownFieldForCropType(),

                  // Radio buttons to select a region
                  SizedBox(height: 16),
                  buildRegionRadioButtons(),

                  // Dropdown for selecting provinces, districts, and divisional secretaries
                  if (selectedRegion == 'Province' ||
                      selectedRegion == 'District' ||
                      selectedRegion == 'Divisional Secretary')
                    buildDropdownFieldForProvincesDistrictsSecretary(),

                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigate to the ShowAgriStatistic page and pass the selected data
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ShowAgriStatistic(
                              selectedRegion: selectedRegion,
                              selectedProvince: selectedProvince,
                              selectedDistrict: selectedDistrict,
                              selectedDivisionalSecretary:
                                  selectedDivisionalSecretary,
                              selectedCropType: selectedCropType,
                            ),
                          ),
                        );
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
                            borderRadius: BorderRadius.circular(
                                15.0), // Set the border radius
                          ),
                        ),
                      ),
                      child: Text('Show'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Show button
        ],
      ),
    );
  }

  Widget buildDropdownFieldForCropType() {
    return buildDropdownField(
      cropTypes,
      'බෝග වර්ගය',
      selectedCropType,
      (newValue) {
        setState(() {
          selectedCropType = newValue;
        });
      },
    );
  }

  Widget buildRegionRadioButtons() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'කලාපය තෝරන්න',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        Column(
          children: [
            RadioListTile(
              title: Text('සියල්ලම'),
              value: 'Sri Lanka',
              groupValue: selectedRegion,
              onChanged: (value) {
                setState(() {
                  selectedRegion = value.toString();
                  selectedProvince = null;
                  selectedDistrict = null;
                  selectedDivisionalSecretary = null;
                });
              },
            ),
            RadioListTile(
              title: Text('පළාත'),
              value: 'Province',
              groupValue: selectedRegion,
              onChanged: (value) {
                setState(() {
                  selectedRegion = value.toString();
                  selectedProvince = null;
                  selectedDistrict = null;
                  selectedDivisionalSecretary = null;
                });
              },
            ),
            RadioListTile(
              title: Text('දිස්ත්‍රික්කය'),
              value: 'District',
              groupValue: selectedRegion,
              onChanged: (value) {
                setState(() {
                  selectedRegion = value.toString();
                  selectedProvince = null;
                  selectedDistrict = null;
                  selectedDivisionalSecretary = null;
                });
              },
            ),
            RadioListTile(
              title: Text('ප්‍රාදේශීය ලේකම් කොට්ඨාශය'),
              value: 'Divisional Secretary',
              groupValue: selectedRegion,
              onChanged: (value) {
                setState(() {
                  selectedRegion = value.toString();
                  selectedProvince = null;
                  selectedDistrict = null;
                  selectedDivisionalSecretary = null;
                });
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget buildDropdownField(List<String> items, String label,
      String? selectedValue, void Function(String?) onChanged) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
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

  Widget buildDropdownFieldForProvincesDistrictsSecretary() {
    if (selectedRegion == 'Province') {
      return buildDropdownField(
        provinces,
        'පළාත තෝරන්න',
        selectedProvince,
        (newValue) {
          setState(() {
            selectedProvince = newValue;
          });
        },
      );
    } else if (selectedRegion == 'District') {
      return buildDropdownField(
        districts,
        'දිස්ත්‍රික්කය තෝරන්න',
        selectedDistrict,
        (newValue) {
          setState(() {
            selectedDistrict = newValue;
          });
        },
      );
    } else if (selectedRegion == 'Divisional Secretary') {
      return buildDropdownField(
        divisionalSecretaries,
        'ප්‍රාදේශීය ලේකම් කොට්ඨාශය තෝරන්න',
        selectedDivisionalSecretary,
        (newValue) {
          setState(() {
            selectedDivisionalSecretary = newValue;
          });
        },
      );
    } else {
      return Container();
    }
  }
}
