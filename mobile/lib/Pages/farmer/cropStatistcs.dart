import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: CropStats(),
  ));
}

class CropStats extends StatefulWidget {
  const CropStats({super.key});

  @override
  State<CropStats> createState() => _CropStatsState();
}

class _CropStatsState extends State<CropStats> {
  String selectedRegion = 'Sri Lanka';
  String? selectedProvince;
  String? selectedDistrict;
  String? selectedDivisionalSecretary;

  List<String> provinces = ["Province 1", "Province 2", "Province 3", "Province 4"]; // Add your province names here
  List<String> districts = ["District 1", "District 2", "District 3", "District 4"]; // Add your district names here
  List<String> divisionalSecretaries = ["Secretary 1", "Secretary 2", "Secretary 3"]; // Add your divisional secretary names here

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Crop Statistics"),
        backgroundColor: const Color.fromARGB(255, 42, 175, 46),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Image
            Image.asset(
              'assets/cropStatImg.jpeg', // Replace 'your_image.png' with the image path
              height: 300,
              width: 300,
              scale: 0.5,
            ),

            // Form for selecting crop type
            SizedBox(height: 16),
            buildDropdownFieldForCropType(),

            // Radio buttons to select a region
            SizedBox(height: 16),
            buildRegionRadioButtons(),

            // Dropdown for selecting provinces, districts, and divisional secretaries
            if (selectedRegion == 'Province' || selectedRegion == 'District' || selectedRegion == 'Divisional Secretary')
              buildDropdownFieldForProvincesDistrictsSecretary(),
          ],
        ),
      ),
    );
  }

  Widget buildDropdownFieldForCropType() {
    // Implement the dropdown for crop type here
    return Container();
  }

  Widget buildRegionRadioButtons() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select a Region',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        Column(
          children: [
            RadioListTile(
              title: Text('Sri Lanka'),
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
              title: Text('Province'),
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
              title: Text('District'),
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
              title: Text('Divisional Secretary'),
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

  Widget buildDropdownField(List<String> items, String label, String? selectedValue, void Function(String?) onChanged) {
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
        'Select a Province',
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
        'Select a District',
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
        'Select a Divisional Secretary',
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
