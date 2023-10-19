import 'package:flutter/material.dart';
import 'package:mobile/Pages/farmer/updateCrops.dart';
import 'CropCard.dart';

class MyCrops extends StatefulWidget {
  const MyCrops({super.key});

  @override
  State<MyCrops> createState() => _MyCropsState();
}

class _MyCropsState extends State<MyCrops> {
  // Example data for different crops
  List<Map<String, String>> crops = [
    {
      'cropType': 'Crop A',
      'agriculturalProperty': 'Property A',
      'waterSource': 'Water A',
      'acres': '10',
      'expectedHarvest': 'Harvest A',
    },
    {
      'cropType': 'Crop B',
      'agriculturalProperty': 'Property B',
      'waterSource': 'Water B',
      'acres': '15',
      'expectedHarvest': 'Harvest B',
    },
    // Add more crop data as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Crops'),
        backgroundColor: const Color.fromARGB(255, 42, 175, 46),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              'assets/myCrops.jpg', // Replace with your image path
              width: double.infinity, // Make the image full-width
              height: 200.0, // Adjust the image height as needed
              fit: BoxFit.cover, // Adjust the BoxFit as needed
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: crops.length,
              itemBuilder: (context, index) {
                final cropData = crops[index];
                return CropCard(
                  cropType: cropData['cropType'] ?? '',
                  agriculturalProperty: cropData['agriculturalProperty'] ?? '',
                  waterSource: cropData['waterSource'] ?? '',
                  area: cropData['acres'] ?? '',
                  expectedHarvest: cropData['expectedHarvest'] ?? '',
                 onUpdate: () {
                    // Navigate to the UpdateCrops page with the relevant data
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => UpdateCrops(
                          cropType: cropData['cropType'] ?? '',
                          agriculturalProperty:
                              cropData['agriculturalProperty'] ?? '',
                          waterSource: cropData['waterSource'] ?? '',
                          area: cropData['acres'] ?? '',
                          expectedHarvest: cropData['expectedHarvest'] ?? '',
                        ),
                      ),
                    );
  },
                  onDelete: () {
                    setState(() {
                      crops.removeAt(index);
                    });
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: MyCrops(),
  ));
}