// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class PublishCrops extends StatefulWidget {
//   final Map<String, dynamic> userData;
//   const PublishCrops({required this.userData});

//   @override
//   _PublishCropsState createState() => _PublishCropsState();
// }

// class _PublishCropsState extends State<PublishCrops> {
//   TextEditingController areaController = TextEditingController();
//   TextEditingController expectedHarvestController = TextEditingController();

//   String? selectedCropType;
//   String? selectedAgriculturalProperty;
//   String? selectedWaterSource;

//   List<String> cropTypes = ["වට්ටක්කා", "කැරට්", "කජු", "තක්කාලි", "මිරිස්"];
//   List<String> agriculturalProperties = [];
//   List<String> waterSources = [];

//   FirebaseFirestore firestore = FirebaseFirestore.instance;

//   @override
//   void initState() {
//     super.initState();
//     fetchDropdownData();
//   }

//   Future<void> fetchDropdownData() async {
//     String email = widget.userData['email'];
//     QuerySnapshot propertiesQuery = await firestore
//         .collection('properties')
//         .where('email', isEqualTo: email)
//         .get();

//     if (propertiesQuery.docs.isNotEmpty) {
//       setState(() {
//         agriculturalProperties = propertiesQuery.docs
//             .map((doc) => doc['propertyname'] as String)
//             .toList();
//         waterSources = propertiesQuery.docs
//             .map((doc) => doc['watercomingmethod'] as String)
//             .toList();
//       });
//     }
//   }

//  Future<void> publishCropsData() async {
//   String cropType = selectedCropType ?? '';
//   String area = areaController.text;
//   String expectedHarvest = expectedHarvestController.text;
  
//   // Retrieve additional fields from the selected property
//   String agricultureDivision = '';
//   String district = '';
//   String mainIrrigationArea = '';
//   String province = '';
//   String secretaryDivision = '';
//   String subIrrigationArea = '';

//   String email = widget.userData['email'];

//   QuerySnapshot propertiesQuery = await firestore
//       .collection('properties')
//       .where('email', isEqualTo: email)
//       .where('propertyname', isEqualTo: selectedAgriculturalProperty)
//       .where('watercomingmethod', isEqualTo: selectedWaterSource)
//       .get();

//   if (propertiesQuery.docs.isNotEmpty) {
//     // Get the first document in the result (there should be only one)
//     DocumentSnapshot propertyDocument = propertiesQuery.docs.first;
//     agricultureDivision = propertyDocument['agriculturedivision'] ?? '';
//     district = propertyDocument['district'] ?? '';
//     mainIrrigationArea = propertyDocument['mainirrigationarea'] ?? '';
//     province = propertyDocument['province'] ?? '';
//     secretaryDivision = propertyDocument['secreterydivision'] ?? '';
//     subIrrigationArea = propertyDocument['subirrigationarea'] ?? '';

//     // Create a new document in the "crops" collection
//     await firestore.collection('crops').add({
//       'cropType': cropType,
//       'agriculturalProperty': selectedAgriculturalProperty,
//       'waterSource': selectedWaterSource,
//       'area': area,
//       'expectedHarvest': expectedHarvest,
//       'email': email,
//       'agricultureDivision': agricultureDivision,
//       'district': district,
//       'mainIrrigationArea': mainIrrigationArea,
//       'province': province,
//       'secretaryDivision': secretaryDivision,
//       'subIrrigationArea': subIrrigationArea,
//       'timestamp': FieldValue.serverTimestamp(),
//     });

//     // Reset form fields or show a success message as needed
//     print('Crops data published successfully');
//   } else {
//     // Handle the case where the properties document was not found
//     print('Selected properties not found for email: $email');
//   }
// }


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("බෝග ඇතුලත් කිරීම"),
//         backgroundColor: const Color.fromARGB(255, 1, 130, 65),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(height: 50),
//             buildDropdownField(selectedCropType, cropTypes, 'බෝග වර්ගය', (String? value) {
//               setState(() {
//                 selectedCropType = value;
//               });
//             }),
//             SizedBox(height: 16),
//             buildDropdownField(selectedAgriculturalProperty, agriculturalProperties, 'කෘෂිකාර්මික දේපල තෝරන්න', (String? value) {
//               setState(() {
//                 selectedAgriculturalProperty = value;
//               });
//             }),
//             SizedBox(height: 16),
//             buildDropdownField(selectedWaterSource, waterSources, 'ජල මූලාශ්‍රය', (String? value) {
//               setState(() {
//                 selectedWaterSource = value;
//               });
//             }),
//             SizedBox(height: 16),
//             buildInputField(areaController, 'භූමි ප්‍රමාණය'),
//             SizedBox(height: 16),
//             buildInputField(expectedHarvestController, 'අපේක්ෂිත අස්වැන්න'),

//             SizedBox(height: 16),

//             Center(
//               child: ElevatedButton(
//                 onPressed: () {
//                   checkAndCreateCropsCollection().then((_) {
//                     publishCropsData();
//                   });
//                 },
//                 style: ButtonStyle(
//                   backgroundColor: MaterialStateProperty.all<Color>(
//                     const Color.fromARGB(255, 1, 130, 65),
//                   ),
//                   minimumSize: MaterialStateProperty.all<Size>(Size(170, 50)),
//                   shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                     RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(15.0),
//                     ),
//                   ),
//                 ),
//                 child: Text('Publish', style: TextStyle(fontSize: 15),),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Future<void> checkAndCreateCropsCollection() async {
//     final DocumentReference collectionRef = firestore.collection('crops').doc('testDoc');
//     final DocumentSnapshot collectionSnapshot = await collectionRef.get();
//     if (!collectionSnapshot.exists) {
//       await collectionRef.set({'dummyField': 'dummyValue'});
//     }
//   }

//   Widget buildDropdownField(
//     String? selectedValue,
//     List<String> items,
//     String labelText,
//     void Function(String?) onChanged,
//   ) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             labelText,
//             style: TextStyle(
//               fontSize: 13.0,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10.0),
//                 color: Colors.white,
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.grey.withOpacity(1.0),
//                     spreadRadius: 2,
//                     blurRadius: 5,
//                     offset: Offset(0, 2),
//                   ),
//                 ],
//               ),
//               child: DropdownButtonFormField<String>(
//                 value: selectedValue,
//                 onChanged: onChanged,
//                 items: items.map((item) {
//                   return DropdownMenuItem(
//                     value: item,
//                     child: Text(item),
//                   );
//                 }).toList(),
//                 decoration: InputDecoration(
//                   contentPadding: const EdgeInsets.all(16.0),
//                   border: InputBorder.none,
//                 ),
//               ),
//             ),
//           ),
//           ],
//       ),
//     );
//   }

//   Widget buildInputField(
//     TextEditingController controller,
//     String labelText,
//   ) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             labelText,
//             style: TextStyle(
//               fontSize: 13.0,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10.0),
//                 color: Colors.white,
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.grey.withOpacity(0.5),
//                     spreadRadius: 2,
//                     blurRadius: 5,
//                     offset: Offset(0, 2),
//                   ),
//                 ],
//               ),
//               child: TextFormField(
//                 controller: controller,
//                 decoration: InputDecoration(
//                   contentPadding: const EdgeInsets.all(16.0),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10.0),
//                   ),
//                 ),
//               ),
//             ),
//           )
//           ],

//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class PublishCrops extends StatefulWidget {
  final Map<String, dynamic> userData;
  const PublishCrops({required this.userData});

  @override
  _PublishCropsState createState() => _PublishCropsState();
}

class _PublishCropsState extends State<PublishCrops> {
  TextEditingController areaController = TextEditingController();
  TextEditingController expectedHarvestController = TextEditingController();

  String? selectedCropType;
  String? selectedAgriculturalProperty;
  String? selectedWaterSource;

  List<String> cropTypes = ["වට්ටක්කා", "කැරට්", "කජු", "තක්කාලි", "මිරිස්"];
  List<String> agriculturalProperties = [];
  List<String> waterSources = [];

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    fetchDropdownData();
  }

  Future<void> fetchDropdownData() async {
    String email = widget.userData['email'];
    QuerySnapshot propertiesQuery = await firestore
        .collection('properties')
        .where('email', isEqualTo: email)
        .get();

    if (propertiesQuery.docs.isNotEmpty) {
      setState(() {
        agriculturalProperties = propertiesQuery.docs
            .map((doc) => doc['propertyname'] as String)
            .toList();
        waterSources = propertiesQuery.docs
            .map((doc) => doc['watercomingmethod'] as String)
            .toList();
      });
    }
  }

  String? validateArea(String? value) {
    if (value == null || value.isEmpty) {
      return 'භූමි ප්‍රමාණය ඇතුලත් කරන්න';
    }
    // if (!RegExp(r'^\d+\sac$').hasMatch(value)) {
    //   return 'භූමි ප්‍රමාණය (100 ac) මෙම ආකාරයට ඇතුලත් කරන්න ';
    // }
    return null;
  }

  String? validateExpectedHarvest(String? value) {
    if (value == null || value.isEmpty) {
      return 'අපේක්ෂිත අස්වැන්න ඇතුලත් කරන්න';
    }
    // if (!RegExp(r'^\d+\sKg$').hasMatch(value)) {
    //   return 'අපේක්ෂිත අස්වැන්න (100 Kg) මෙම ආකාරයට ඇතුලත් කරන්න ';
    // }
    return null;
  }

  Future<void> publishCropsData() async {
    if (_formKey.currentState!.validate()) {
      // Form is valid, proceed with data publication.
      String cropType = selectedCropType ?? '';
      String area = areaController.text;
      String expectedHarvest = expectedHarvestController.text;

      // Retrieve additional fields from the selected property
      String agricultureDivision = '';
      String district = '';
      String mainIrrigationArea = '';
      String province = '';
      String secretaryDivision = '';
      String subIrrigationArea = '';

      String email = widget.userData['email'];

      QuerySnapshot propertiesQuery = await firestore
          .collection('properties')
          .where('email', isEqualTo: email)
          .where('propertyname', isEqualTo: selectedAgriculturalProperty)
          .where('watercomingmethod', isEqualTo: selectedWaterSource)
          .get();

      if (propertiesQuery.docs.isNotEmpty) {
        // Get the first document in the result (there should be only one)
        DocumentSnapshot propertyDocument = propertiesQuery.docs.first;
        agricultureDivision = propertyDocument['agriculturedivision'] ?? '';
        district = propertyDocument['district'] ?? '';
        mainIrrigationArea = propertyDocument['mainirrigationarea'] ?? '';
        province = propertyDocument['province'] ?? '';
        secretaryDivision = propertyDocument['secreterydivision'] ?? '';
        subIrrigationArea = propertyDocument['subirrigationarea'] ?? '';

        // Create a new document in the "crops" collection
        await firestore.collection('crops').add({
          'cropType': cropType,
          'agriculturalProperty': selectedAgriculturalProperty,
          'waterSource': selectedWaterSource,
          'area': area,
          'expectedHarvest': expectedHarvest,
          'email': email,
          'agricultureDivision': agricultureDivision,
          'district': district,
          'mainIrrigationArea': mainIrrigationArea,
          'province': province,
          'secretaryDivision': secretaryDivision,
          'subIrrigationArea': subIrrigationArea,
          'timestamp': FieldValue.serverTimestamp(),
        });

        areaController.clear();
      expectedHarvestController.clear();

      // Show a SnackBar with the success message
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     content: Text('Crop details published successfully'),
      //   ),
      // );

      // Show the success dialog
      _showSuccessDialog();
  
  

        // Reset form fields or show a success message as needed
        print('Crops data published successfully');
      } else {
        // Handle the case where the properties document was not found
        print('Selected properties not found for email: $email');
      }
    }
  }

 Future<void> _showSuccessDialog() async {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Row(
          children: [
            Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 32,
            ),
            SizedBox(width: 8),
            Text('සාර්ථකයි'),
          ],
        ),
        content: Text('ඔබ භෝග විස්තර සාර්ථකව ඇතුලත් කරන ලදී!'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}


  Future<void> checkAndCreateCropsCollection() async {
    final DocumentReference collectionRef = firestore.collection('crops').doc('testDoc');
    final DocumentSnapshot collectionSnapshot = await collectionRef.get();
    if (!collectionSnapshot.exists) {
      await collectionRef.set({'dummyField': 'dummyValue'});
    }
  }

  Widget buildDropdownField(
    String? selectedValue,
    List<String> items,
    String labelText,
    void Function(String?) onChanged,
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

  Widget buildInputField(
    TextEditingController controller,
    String labelText,
    String? Function(String?)? validator,
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
                validator: validator,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(16.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
      )],
        ),
      
    );
  
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("බෝග ඇතුලත් කිරීම"),
        backgroundColor: const Color.fromARGB(255, 1, 130, 65),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 50),
              buildDropdownField(selectedCropType, cropTypes, 'බෝග වර්ගය', (String? value) {
                setState(() {
                  selectedCropType = value;
                });
              }),
              SizedBox(height: 16),
              buildDropdownField(selectedAgriculturalProperty, agriculturalProperties, 'කෘෂිකාර්මික දේපල තෝරන්න', (String? value) {
                setState(() {
                  selectedAgriculturalProperty = value;
                });
              }),
              SizedBox(height: 16),
              buildDropdownField(selectedWaterSource, waterSources, 'ජල මූලාශ්‍රය', (String? value) {
                setState(() {
                  selectedWaterSource = value;
                });
              }),
              SizedBox(height: 16),
              buildInputField(areaController, 'භූමි ප්‍රමාණය', validateArea),
              SizedBox(height: 16),
              buildInputField(expectedHarvestController, 'අපේක්ෂිත අස්වැන්න', validateExpectedHarvest),

              SizedBox(height: 16),

              Center(
                child: ElevatedButton(
                  onPressed: () {
                    checkAndCreateCropsCollection().then((_) {
                      publishCropsData();
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      const Color.fromARGB(255, 1, 130, 65),
                    ),
                    minimumSize: MaterialStateProperty.all<Size>(Size(170, 50)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                  ),
                  child: Text('පලකරන්න', style: TextStyle(fontSize: 15)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Future<void> checkAndCreateCropsCollection() async {
  //   final DocumentReference collectionRef = firestore.collection('crops').doc('testDoc');
  //   final DocumentSnapshot collectionSnapshot = await collectionRef.get();
  //   if (!collectionSnapshot.exists) {
  //     await collectionRef.set({'dummyField': 'dummyValue'});
  //   }
  // }
}

