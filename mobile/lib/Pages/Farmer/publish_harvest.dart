import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mobile/Services/FarmerServices/alert_services.dart';
import 'package:mobile/Services/FarmerServices/farmer_profile_services.dart';

class PublishHarvest extends StatefulWidget {
  final Map<String, dynamic> userData;
  const PublishHarvest({required this.userData});

  @override
  _PublishHarvestState createState() => _PublishHarvestState();
}

class _PublishHarvestState extends State<PublishHarvest> {
  Map<String, dynamic> userProfile =
      Map<String, dynamic>(); // Initialize userData

  @override
  void initState() {
    super.initState();
    // Call the getUserProfile method to get user data
    FarmerProfileService().getUserProfile().then((data) {
      setState(() {
        userProfile = data;
      });
    });
  }

  final TextEditingController typeController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descController = TextEditingController();

  // String? selectedCropType;
  // List<String> cropTypes = ["Crop Type 1", "Crop Type 2", "Crop Type 3"];

  File? _image;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("අස්වැන්න පළ කරන්න"),
        backgroundColor: Color.fromARGB(255, 1, 130, 65),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50),
            buildInputField(typeController, 'බෝග වර්ගය'),
            SizedBox(height: 16),
            buildInputField(amountController, 'සම්පූර්ණ අස්වැන්න'),
            SizedBox(height: 16),
            buildInputField(priceController, 'මිල (1kg සඳහා)'),
            SizedBox(height: 16),
            buildInputField(descController, 'විස්තර'),
            SizedBox(height: 16),
            buildImageUploadButton(),
            SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Handle form submission
                  String cropType = typeController.text;
                  double amount = double.tryParse(amountController.text) ?? 0.0;
                  double price = double.tryParse(priceController.text) ?? 0.0;
                  String description = descController.text;

                  _uploadData(cropType, amount, price, description);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xaf018241),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  minimumSize: Size(100, 45),
                ),
                child: Text(
                  'පළ කරන්න',
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ),
          ],
        ),
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
              fontSize: 18.0,
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

  Widget buildImageUploadButton() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'රූපය උඩුගත කරන්න',
          style: TextStyle(
            fontSize: 18.0,
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
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.camera_alt),
                  onPressed: () {
                    _pickImage(ImageSource.camera);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.photo),
                  onPressed: () {
                    _pickImage(ImageSource.gallery);
                  },
                ),
                if (_image != null)
                  if (kIsWeb)
                    Image.network(
                      'path_to_image_on_web', // Provide the URL of the image on the web
                      width: 100,
                      height: 100,
                    )
                  else
                    Image.file(
                      _image!,
                      width: 100,
                      height: 100,
                    )
                else
                  Text("රූපයක් තෝරා නැත"),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().getImage(source: source);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  Future<void> _uploadData(
  String cropType,
  double amount,
  double price,
  String description,
  ) async {
  final user = _auth.currentUser;
  if (user == null) {
    // Handle the case where the user is not logged in
    return;
  }

  if (cropType.isEmpty || amount <= 0 || price <= 0 || description.isEmpty || _image == null) {
    await showCustomAlertDialog(
      context: context,
      title: 'අසාර්ථකයි',
      message: 'සියලුම ක්ෂේත්‍ර පිරවිය යුතුයි.',
      buttonText: 'අවලංගු කරන්න',
      isSuccess: false,
      onButtonPressed: () {
        Navigator.of(context).pop(); // Close the dialog
      },
    );
    return;
  }

    try {
      if (_image != null) {
        final imageUrl = await _uploadImage(_image!, user.uid);

        // After successfully uploading the image, save the data to Firestore
        final Map<String, dynamic> harvestData = {
          'type': cropType,
          'price': price,
          'amount': amount,
          'description': description,
          'imageURL': imageUrl,
        };

        final CollectionReference publishHarvestCollection =
            _firestore.collection('published_harvest');

        // Check if a document with the user's ID already exists in the collection
        final DocumentSnapshot userDoc =
            await publishHarvestCollection.doc(user.uid).get();

        if (userDoc.exists) {
          // If the document exists, add the item to the 'items' array field
          await publishHarvestCollection.doc(user.uid).update({
            'items': FieldValue.arrayUnion([harvestData]),
          });
        } else {
          // If the document does not exist, create a new one with the user's ID
          await publishHarvestCollection.doc(user.uid).set({
            'userid': user.uid,
            'items': [harvestData],
          });
        }
        await showCustomAlertDialog(
          context: context,
          title: 'සාර්ථකයි',
          message: 'අස්වැන්න සාර්ථකව පළ කරන ලදී.',
          buttonText: 'හරි',
          onButtonPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          isSuccess: true,
        );
        print('Data saved to Firestore.');
      } else {
        print('Please select an image.');
      }
    } catch (e) {
      await showCustomAlertDialog(
          context: context,
          title: 'අසාර්ථකයි',
          message: 'අස්වැන්න පළ කිරීම අසාර්ථකයි',
          buttonText: 'අවලංගු කරන්න',
          onButtonPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          isSuccess: false,
        );
    }
  }
  Future<String> _uploadImage(File image, String userId) async {
    final Reference storageRef =
        _storage.ref().child('user_images/$userId/${DateTime.now()}.jpg');

    final UploadTask uploadTask = storageRef.putFile(image);

    try {
      await uploadTask;
      return await storageRef.getDownloadURL();
    } catch (e) {
      print('Error uploading image: $e');
      throw e;
    }
  }
  Future<void> showCustomAlertDialog({
    required BuildContext context,
    required String title,
    required String message,
    required String buttonText,
    required VoidCallback onButtonPressed,
    required bool isSuccess,
  }) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomAlertDialog(
          title: title,
          message: message,
          buttonText: buttonText,
          onButtonPressed: onButtonPressed,
          isSuccess: isSuccess,
        );
      },
    );
  }
}
