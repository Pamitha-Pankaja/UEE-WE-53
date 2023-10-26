// import 'package:flutter/material.dart';
// import 'package:mobile/Pages/farmer/updateCrops.dart';
// import 'CropCard.dart';

// class MyCrops extends StatefulWidget {
//   //const MyCrops({super.key});
//   final Map<String, dynamic> userData;
//   const MyCrops({required this.userData});

//   @override
//   State<MyCrops> createState() => _MyCropsState();
// }

// class _MyCropsState extends State<MyCrops> {
//   // Example data for different crops
//   List<Map<String, String>> crops = [
//     {
//       'cropType': 'Crop A',
//       'agriculturalProperty': 'Property A',
//       'waterSource': 'Water A',
//       'acres': '10',
//       'expectedHarvest': 'Harvest A',
//     },
//     {
//       'cropType': 'Crop B',
//       'agriculturalProperty': 'Property B',
//       'waterSource': 'Water B',
//       'acres': '15',
//       'expectedHarvest': 'Harvest B',
//     },
//     // Add more crop data as needed
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('My Crops'),
//         backgroundColor: const Color.fromARGB(255, 42, 175, 46),
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Image.asset(
//               'assets/myCrops.jpg', // Replace with your image path
//               width: double.infinity, // Make the image full-width
//               height: 200.0, // Adjust the image height as needed
//               fit: BoxFit.cover, // Adjust the BoxFit as needed
//             ),
//           ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: crops.length,
//               itemBuilder: (context, index) {
//                 final cropData = crops[index];
//                 return CropCard(
//                   cropType: cropData['cropType'] ?? '',
//                   agriculturalProperty: cropData['agriculturalProperty'] ?? '',
//                   waterSource: cropData['waterSource'] ?? '',
//                   area: cropData['acres'] ?? '',
//                   expectedHarvest: cropData['expectedHarvest'] ?? '',
//                   onUpdate: () {
//                     // Navigate to the UpdateCrops page with the relevant data
//                     Navigator.of(context).push(
//                       MaterialPageRoute(
//                         builder: (context) => UpdateCrops(
//                           cropType: cropData['cropType'] ?? '',
//                           agriculturalProperty:
//                               cropData['agriculturalProperty'] ?? '',
//                           waterSource: cropData['waterSource'] ?? '',
//                           area: cropData['acres'] ?? '',
//                           expectedHarvest: cropData['expectedHarvest'] ?? '',
//                         ),
//                       ),
//                     );
//                   },
//                   onDelete: () {
//                     setState(() {
//                       crops.removeAt(index);
//                     });
//                   },
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'CropCard.dart';
import 'package:mobile/Pages/farmer/updateCrops.dart';

class MyCrops extends StatefulWidget {
  final Map<String, dynamic> userData;
  const MyCrops({required this.userData});

  @override
  State<MyCrops> createState() => _MyCropsState();
}

class _MyCropsState extends State<MyCrops> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot> fetchCrops() {
    String userEmail = widget.userData['email']; // Assuming the email is stored in the 'email' field of userData
    return firestore.collection('crops').where('email', isEqualTo: userEmail).snapshots();
  }

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
              'assets/myCrops.jpg',
              height: 200, // Replace with the correct image path
              width: double.infinity, // Make the image full-width
              fit: BoxFit.cover, // Adjust the BoxFit as needed
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: fetchCrops(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }

                final cropDocuments = snapshot.data?.docs;

                return ListView.builder(
                  itemCount: cropDocuments?.length,
                  itemBuilder: (context, index) {
                    final cropData = cropDocuments?[index].data() as Map<String, dynamic>;

                    return CropCard(
                      cropType: cropData['cropType'] ?? '',
                      agriculturalProperty: cropData['agriculturalProperty'] ?? '',
                      waterSource: cropData['waterSource'] ?? '',
                      area: cropData['area'] ?? '',
                      expectedHarvest: cropData['expectedHarvest'] ?? '',
        
                      onUpdate: () {
                        // Navigate to the UpdateCrops page with the relevant data
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => UpdateCrops(
                              cropType: cropData['cropType'] ?? '',
                              agriculturalProperty: cropData['agriculturalProperty'] ?? '',
                              waterSource: cropData['waterSource'] ?? '',
                              area: cropData['area'] ?? '',
                              expectedHarvest: cropData['expectedHarvest'] ?? '',
                              userEmail: widget.userData['email'],
                            ),
                          ),
                        );
                      },
                      onDelete: () {
                        setState(() {
                          var crops;
                          crops.removeAt(index);
                        });
                      },
                    );
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
