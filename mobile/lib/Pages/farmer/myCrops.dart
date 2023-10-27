// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'CropCard.dart';
// import 'package:mobile/Pages/farmer/updateCrops.dart';

// class MyCrops extends StatefulWidget {
//   final Map<String, dynamic> userData;
//   const MyCrops({required this.userData});

//   @override
//   State<MyCrops> createState() => _MyCropsState();
// }

// class _MyCropsState extends State<MyCrops> {
//   final FirebaseFirestore firestore = FirebaseFirestore.instance;

//   Stream<QuerySnapshot> fetchCrops() {
//     String userEmail = widget.userData['email']; // Assuming the email is stored in the 'email' field of userData
//     return firestore.collection('crops').where('email', isEqualTo: userEmail).snapshots();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('My Crops'),
//         backgroundColor: Color.fromARGB(255, 1, 130, 65),
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Image.asset(
//               'assets/myCrops.jpg',
//               height: 200, // Replace with the correct image path
//               width: double.infinity, // Make the image full-width
//               fit: BoxFit.cover, // Adjust the BoxFit as needed
//             ),
//           ),
//           Expanded(
//             child: StreamBuilder<QuerySnapshot>(
//               stream: fetchCrops(),
//               builder: (context, snapshot) {
//                 if (!snapshot.hasData) {
//                   return Center(child: CircularProgressIndicator());
//                 }

//                 final cropDocuments = snapshot.data?.docs;

//                 return ListView.builder(
//                   itemCount: cropDocuments?.length,
//                   itemBuilder: (context, index) {
//                     final cropData = cropDocuments?[index].data() as Map<String, dynamic>;

//                     return CropCard(
//                       cropType: cropData['cropType'] ?? '',
//                       agriculturalProperty: cropData['agriculturalProperty'] ?? '',
//                       waterSource: cropData['waterSource'] ?? '',
//                       area: cropData['area'] ?? '',
//                       expectedHarvest: cropData['expectedHarvest'] ?? '',

//                       onUpdate: () {
//                         // Navigate to the UpdateCrops page with the relevant data
//                         Navigator.of(context).push(
//                           MaterialPageRoute(
//                             builder: (context) => UpdateCrops(
//                               cropType: cropData['cropType'] ?? '',
//                               agriculturalProperty: cropData['agriculturalProperty'] ?? '',
//                               waterSource: cropData['waterSource'] ?? '',
//                               area: cropData['area'] ?? '',
//                               expectedHarvest: cropData['expectedHarvest'] ?? '',
//                               userEmail: widget.userData['email'],
//                             ),
//                           ),
//                         );
//                       },
//                       onDelete: () {
//                         setState(() {
//                           var crops;
//                           crops.removeAt(index);
//                         });
//                       },
//                     );
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

  Future<void> deleteCrop(String docId) async {
    try {
      await FirebaseFirestore.instance.collection('crops').doc(docId).delete();
      print('Crop deleted successfully');
    } catch (e) {
      print('Error deleting crop: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Crops'),
        backgroundColor: Color.fromARGB(255, 1, 130, 65),
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
                        final docId = cropDocuments![index].id;
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Row(
                              children: [
                                Icon(
                                  Icons.warning,
                                  color: Colors.red,
                                  size: 28,
                                ),
                                SizedBox(width: 8),
                                Text("Delete Crop"),
                              ],
                            ),
                            content: Text("Do you want to delete this crop?"),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  "No",
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 44, 138, 7),
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  deleteCrop(docId);
                                },
                                child: Text(
                                  "Yes",
                                  style: TextStyle(
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
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

