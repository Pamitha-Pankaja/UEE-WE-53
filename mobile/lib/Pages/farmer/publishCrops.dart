import 'package:flutter/material.dart';

class PublishCrops extends StatefulWidget {
  const PublishCrops({Key? key}) : super(key: key);

  @override
  _PublishCropsState createState() => _PublishCropsState();
}

class _PublishCropsState extends State<PublishCrops> {
  TextEditingController areaController = TextEditingController();
  TextEditingController expectedHarvestController = TextEditingController();

  String? selectedCropType;
  String? selectedAgriculturalProperty;
  String? selectedWaterSource;

  List<String> cropTypes = ["Crop Type 1", "Crop Type 2", "Crop Type 3"];
  List<String> agriculturalProperties = ["Property 1", "Property 2", "Property 3"];
  List<String> waterSources = ["Source 1", "Source 2", "Source 3"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("බෝග ඇතුලත් කිරීම"),
        backgroundColor: const Color.fromARGB(255, 42, 175, 46),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50),
            buildDropdownField(selectedCropType, cropTypes, 'බෝග වර්ගය'),
            SizedBox(height: 16),
            buildDropdownField(selectedAgriculturalProperty, agriculturalProperties, 'කෘෂිකාර්මික දේපල තෝරන්න'),
            SizedBox(height: 16),
            buildDropdownField(selectedWaterSource, waterSources, 'ජල මූලාශ්‍රය'),
            SizedBox (height: 16),
            buildInputField(areaController, 'භූමි ප්‍රමාණය'),
            SizedBox(height: 16),
            buildInputField(expectedHarvestController, 'අපේක්ෂිත අස්වැන්න'),

            SizedBox(height: 16),

            Center(
              child: ElevatedButton(
                onPressed: () {
                
                  // Handle form submission
                  String cropType = selectedCropType ?? '';
                  String agriculturalProperty = selectedAgriculturalProperty ?? '';
                  String waterSource = selectedWaterSource ?? '';
                  String area = areaController.text;
                  String expectedHarvest = expectedHarvestController.text;
                  
                  // Process the data or make API calls as needed
                  print('Crop Type: $cropType');
                  print('Agriculture Property: $agriculturalProperty');
                  print('Water Source: $waterSource');
                  print('Area: $area');
                  print('Expected Harvest: $expectedHarvest');
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    const Color.fromARGB(255, 42, 175, 46),
                  ),
                  minimumSize: MaterialStateProperty.all<Size>(Size(170, 50)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0), // Set the border radius
        ),
      ),
                ),
                
                child: Text('පළ කරන්න',style: TextStyle(fontSize: 15),),
                
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
    home: PublishCrops(),
  ));
}


