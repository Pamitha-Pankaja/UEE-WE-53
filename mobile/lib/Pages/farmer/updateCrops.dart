import 'package:flutter/material.dart';

class UpdateCrops extends StatefulWidget {
  final String cropType;
  final String agriculturalProperty;
  final String waterSource;
  final String area;
  final String expectedHarvest;

  UpdateCrops({
    required this.cropType,
    required this.agriculturalProperty,
    required this.waterSource,
    required this.area,
    required this.expectedHarvest,
  });

  @override
  _UpdateCropsState createState() => _UpdateCropsState();
}

class _UpdateCropsState extends State<UpdateCrops> {
  TextEditingController areaController = TextEditingController();
  TextEditingController expectedHarvestController = TextEditingController();

  String? selectedCropType;
  String? selectedAgriculturalProperty;
  String? selectedWaterSource;

  List<String> cropTypes = ["Crop A", "Crop B", "Crop C"];
  List<String> agriculturalProperties = ["Property A", "Property B", "Property C"];
  List<String> waterSources = ["Water A", "Water B", "Water C"];

  @override
  void initState() {
    super.initState();
    // Initialize dropdown values with the values from the card
    selectedCropType = widget.cropType;
    selectedAgriculturalProperty = widget.agriculturalProperty;
    selectedWaterSource = widget.waterSource;
    areaController.text = widget.area;
    expectedHarvestController.text = widget.expectedHarvest;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Crops"),
        backgroundColor: const Color.fromARGB(255, 42, 175, 46),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50),
            buildDropdownField(selectedCropType, cropTypes, 'Crop Type'),
            SizedBox(height: 16),
            buildDropdownField(selectedAgriculturalProperty, agriculturalProperties, 'Agriculture Property'),
            SizedBox(height: 16),
            buildDropdownField(selectedWaterSource, waterSources, 'Water Source'),
            SizedBox(height: 16),
            buildInputField(areaController, 'Area'),
            SizedBox(height: 16),
            buildInputField(expectedHarvestController, 'Expected Harvest'),
            SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Handle the update logic here, you can use the values from the controllers
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
                child: Text('Update', style: TextStyle(fontSize: 15)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDropdownField(String? selectedValue, List<String> items, String labelText) {
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

  Widget buildInputField(TextEditingController controller, String labelText) {
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
