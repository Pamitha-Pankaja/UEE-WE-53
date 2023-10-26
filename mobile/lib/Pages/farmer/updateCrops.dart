// import 'package:flutter/material.dart';


// class UpdateCrops extends StatefulWidget {
 
//   final String cropType;
//   final String agriculturalProperty;
//   final String waterSource;
//   final String area;
//   final String expectedHarvest;

//   UpdateCrops({
//     required this.cropType,
//     required this.agriculturalProperty,
//     required this.waterSource,
//     required this, required userEmail.area,
//     required this.expectedHarvest,
//   });

//   @override
//   _UpdateCropsState createState() => _UpdateCropsState();
// }

// class _UpdateCropsState extends State<UpdateCrops> {
//   TextEditingController areaController = TextEditingController();
//   TextEditingController expectedHarvestController = TextEditingController();

//   String? selectedCropType;
//   String? selectedAgriculturalProperty;
//   String? selectedWaterSource;

//   List<String> cropTypes = ["Crop A", "Crop B", "Crop C"];
//   List<String> agriculturalProperties = ["Property A", "Property B", "Property C"];
//   List<String> waterSources = ["Water A", "Water B", "Water C"];

//   @override
//   void initState() {
//     super.initState();
//     // Initialize dropdown values with the values from the card
//     selectedCropType = widget.cropType;
//     selectedAgriculturalProperty = widget.agriculturalProperty;
//     selectedWaterSource = widget.waterSource;
//     areaController.text = widget.area;
//     expectedHarvestController.text = widget.expectedHarvest;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Update Crops"),
//         backgroundColor: const Color.fromARGB(255, 42, 175, 46),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(height: 50),
//             buildDropdownField(selectedCropType, cropTypes, 'Crop Type'),
//             SizedBox(height: 16),
//             buildDropdownField(selectedAgriculturalProperty, agriculturalProperties, 'Agriculture Property'),
//             SizedBox(height: 16),
//             buildDropdownField(selectedWaterSource, waterSources, 'Water Source'),
//             SizedBox(height: 16),
//             buildInputField(areaController, 'Area'),
//             SizedBox(height: 16),
//             buildInputField(expectedHarvestController, 'Expected Harvest'),
//             SizedBox(height: 16),
//             Center(
//               child: ElevatedButton(
//                 onPressed: () {
//                   // Handle the update logic here, you can use the values from the controllers
//                 },
//                 style: ButtonStyle(
//                   backgroundColor: MaterialStateProperty.all<Color>(
//                     const Color.fromARGB(255, 42, 175, 46),
//                   ),
//                   minimumSize: MaterialStateProperty.all<Size>(Size(170, 50)),
//                   shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                     RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(15.0),
//                     ),
//                   ),
//                 ),
//                 child: Text('Update', style: TextStyle(fontSize: 15)),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget buildDropdownField(String? selectedValue, List<String> items, String labelText) {
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
//                 onChanged: (newValue) {
//                   setState(() {
//                     selectedValue = newValue;
//                   });
//                 },
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
//         ],
//       ),
//     );
//   }

//   Widget buildInputField(TextEditingController controller, String labelText) {
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
//           ),
//         ],
//       ),
//     );
//   }
// }



// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'myCrops.dart';

// class UpdateCrops extends StatefulWidget {
//   final String cropType;
//   final String agriculturalProperty;
//   final String waterSource;
//   final String area;
//   final String expectedHarvest;
//   final String userEmail;

//   UpdateCrops({
//     required this.cropType,
//     required this.agriculturalProperty,
//     required this.waterSource,
//     required this.area,
//     required this.expectedHarvest,
//     required this.userEmail, // Pass the user's email to fetch properties
//   });

//   @override
//   _UpdateCropsState createState() => _UpdateCropsState();
// }

// class _UpdateCropsState extends State<UpdateCrops> {
//   TextEditingController areaController = TextEditingController();
//   TextEditingController expectedHarvestController = TextEditingController();

//   String? selectedCropType;
//   String? selectedAgriculturalProperty;
//   String? selectedWaterSource;

//   List<String> cropTypes = ["Miris", "Crop B", "Crop C"];
//   List<String> agriculturalProperties = []; // Populate this with data from properties collection
//   List<String> waterSources = []; // Populate this with data from properties collection

//   final FirebaseFirestore firestore = FirebaseFirestore.instance;

//   @override
//   void initState() {
//     super.initState();
//     // Set the default values based on card data
//     selectedCropType = widget.cropType;
//     selectedAgriculturalProperty = widget.agriculturalProperty;
//     selectedWaterSource = widget.waterSource;
//     areaController.text = widget.area;
//     expectedHarvestController.text = widget.expectedHarvest;

//     // Fetch data for the "Agriculture Property" dropdown
//     fetchAgriculturalProperties();

//     // Fetch data for the "Water Source" dropdown
//     fetchWaterSources();
//   }

//   // Function to fetch data for the "Agriculture Property" dropdown
//   Future<void> fetchAgriculturalProperties() async {
//     QuerySnapshot propertiesQuery = await firestore
//         .collection('properties')
//         .where('email', isEqualTo: widget.userEmail)
//         .get();

//     if (propertiesQuery.docs.isNotEmpty) {
//       setState(() {
//         agriculturalProperties = propertiesQuery.docs
//             .map((doc) => doc['propertyname'] as String)
//             .toList();
//       });
//     }
//   }

//   // Function to fetch data for the "Water Source" dropdown
//   Future<void> fetchWaterSources() async {
//     QuerySnapshot propertiesQuery = await firestore
//         .collection('properties')
//         .where('email', isEqualTo: widget.userEmail)
//         .get();

//     if (propertiesQuery.docs.isNotEmpty) {
//       setState(() {
//         waterSources = propertiesQuery.docs
//             .map((doc) => doc['watercomingmethod'] as String)
//             .toList();
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Update Crops"),
//         backgroundColor: const Color.fromARGB(255, 42, 175, 46),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(height: 50),
//             buildDropdownField(selectedCropType, cropTypes, 'Crop Type'),
//             SizedBox(height: 16),
//             buildDropdownField(selectedAgriculturalProperty, agriculturalProperties, 'Agriculture Property'),
//             SizedBox(height: 16),
//             buildDropdownField(selectedWaterSource, waterSources, 'Water Source'),
//             SizedBox(height: 16),
//             buildInputField(areaController, 'Area'),
//             SizedBox(height: 16),
//             buildInputField(expectedHarvestController, 'Expected Harvest'),
//             SizedBox(height: 16),
//             Center(
//               child: ElevatedButton(
//                 onPressed: () {
//                   // Handle the update logic here, you can use the values from the controllers
//                 },
//                 style: ButtonStyle(
//                   backgroundColor: MaterialStateProperty.all<Color>(
//                     const Color.fromARGB(255, 42, 175, 46),
//                   ),
//                   minimumSize: MaterialStateProperty.all<Size>(Size(170, 50)),
//                   shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                     RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(15.0),
//                     ),
//                   ),
//                 ),
//                 child: Text('Update', style: TextStyle(fontSize: 15)),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget buildDropdownField(String? selectedValue, List<String> items, String labelText) {
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
//                 onChanged: (newValue) {
//                   setState(() {
//                     selectedValue = newValue;
//                   });
//                 },
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
//         ],
//       ),
//     );
//   }

//   Widget buildInputField(TextEditingController controller, String labelText) {
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
//           ),
//         ],
//       ),
//     );
//   }
// }




import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UpdateCrops extends StatefulWidget {
  final String cropType;
  final String agriculturalProperty;
  final String waterSource;
  final String area;
  final String expectedHarvest;
  final String userEmail;

  UpdateCrops({
    required this.cropType,
    required this.agriculturalProperty,
    required this.waterSource,
    required this.area,
    required this.expectedHarvest,
    required this.userEmail,
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

  List<String> cropTypes = ["Miris", "Carrot", "Crop C"];
  List<String> agriculturalProperties = []; // Populate this with data from properties collection
  List<String> waterSources = []; // Populate this with data from properties collection

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    // Set the default values based on card data
    selectedCropType = widget.cropType;
    selectedAgriculturalProperty = widget.agriculturalProperty;
    selectedWaterSource = widget.waterSource;
    areaController.text = widget.area;
    expectedHarvestController.text = widget.expectedHarvest;

    // Fetch data for the "Agriculture Property" dropdown
    fetchAgriculturalProperties();

    // Fetch data for the "Water Source" dropdown
    fetchWaterSources();
  }

  // Function to fetch data for the "Agriculture Property" dropdown
  Future<void> fetchAgriculturalProperties() async {
    QuerySnapshot propertiesQuery = await firestore
        .collection('properties')
        .where('email', isEqualTo: widget.userEmail)
        .get();

    if (propertiesQuery.docs.isNotEmpty) {
      setState(() {
        agriculturalProperties = propertiesQuery.docs
            .map((doc) => doc['propertyname'] as String)
            .toList();
      });
    }
  }

  // Function to fetch data for the "Water Source" dropdown
  Future<void> fetchWaterSources() async {
    QuerySnapshot propertiesQuery = await firestore
        .collection('properties')
        .where('email', isEqualTo: widget.userEmail)
        .get();

    if (propertiesQuery.docs.isNotEmpty) {
      setState(() {
        waterSources = propertiesQuery.docs
            .map((doc) => doc['watercomingmethod'] as String)
            .toList();
      });
    }
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
                onPressed: () async {
                  // Initialize Firestore instance if you haven't already
                  FirebaseFirestore firestore = FirebaseFirestore.instance;

                  // Prepare the data to be updated
                  Map<String, dynamic> updatedData = {
                    'cropType': selectedCropType,
                    'agriculturalProperty': selectedAgriculturalProperty,
                    'waterSource': selectedWaterSource,
                    'area': areaController.text,
                    'expectedHarvest': expectedHarvestController.text,
                  };

                  // Query the "crops" collection based on email and cropType
                  QuerySnapshot querySnapshot = await firestore
                      .collection('crops')
                      .where('email', isEqualTo: widget.userEmail)
                      .where('cropType', isEqualTo: widget.cropType)
                      .get();

                  if (querySnapshot.docs.isNotEmpty) {
                    // Get the first document in the result (there should be only one)
                    DocumentSnapshot document = querySnapshot.docs.first;

                    // Get the document reference
                    DocumentReference docRef = document.reference;

                    try {
                      // Update the document in Firestore
                      await docRef.update(updatedData);

                      // Show a success message or navigate to another screen
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Crop updated successfully!')),
                      );
                    } catch (e) {
                      // Handle any errors that occur during the update
                      print('Error updating crop: $e');
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Error updating crop. Please try again.')),
                      );
                    }
                  } else {
                    // Handle the case where the document was not found
                    print('Document not found for email: ${widget.userEmail}, cropType: ${widget.cropType}');
                  }
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
