import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:mobile/Services/FarmerServices/farmer_profile_services.dart';

class FarmerProfile extends StatefulWidget {
  final Map<String, dynamic> userData;
  FarmerProfile({required this.userData, Key? key}) : super(key: key);

  @override
  _FarmerProfileState createState() => _FarmerProfileState();
}

class _FarmerProfileState extends State<FarmerProfile> {
  String farmerName = '';
  String email = '';
  String password = '';
  String contact = '';
  String address = '';
  String profileImageURL = '';

  TextEditingController farmerNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  bool farmerNameEditMode = false;
  bool emailEditMode = false;
  bool passwordEditMode = false;
  bool contactEditMode = false;
  bool addressEditMode = false;

  List<File> _profileImages = [];
  int _currentImageIndex = 0;
  final FarmerProfileService _farmerProfileService =
      FarmerProfileService(); // Instantiate your service

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final firestore = FirebaseFirestore.instance;

      firestore
          .collection('farmers')
          .where('userId', isEqualTo: user.uid)
          .get()
          .then((QuerySnapshot querySnapshot) {
        if (querySnapshot.docs.isNotEmpty) {
          final userDoc = querySnapshot.docs[0].data() as Map<String, dynamic>;

          setState(() {
            email = userDoc['email'] ?? '';
            password = userDoc['password'] ?? '';
            farmerName = userDoc['farmerName'] ?? '';
            contact = userDoc['contact'] ?? '';
            address = userDoc['address'] ?? '';
            profileImageURL = userDoc['profileImageURL'] ?? '';

            emailController.text = email;
            passwordController.text = password;
            farmerNameController.text = farmerName;
            contactController.text = contact;
            addressController.text = address;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("මගේ ගිණුම"),
        backgroundColor: const Color.fromARGB(255, 1, 130, 65),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            );
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 30.0),
          Align(
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                Container(
                  height: 130,
                  width: 130,
                  margin: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: ClipOval(
                    child: profileImageURL.isNotEmpty
                        ? Image.network(
                            profileImageURL,
                            width: 150,
                            height: 150,
                            scale: 1.0,
                            fit: BoxFit.cover,
                          )
                        : Center(
                            child: Text(
                              farmerNameController.text.isNotEmpty
                                  ? farmerNameController.text[0]
                                  : '',
                              style: TextStyle(
                                fontSize: 38.0,
                                color: Color.fromARGB(255, 14, 151, 82),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                  ),
                ),
                const SizedBox(height: 15.0),
                Text(
                  farmerNameController.text,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(top: 20.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildEditableField(
                      farmerNameController,
                      'නම',
                      farmerNameEditMode,
                      () {
                        setState(() {
                          farmerNameEditMode = !farmerNameEditMode;
                        });
                      },
                      false,
                    ),
                    buildEditableField(
                      emailController,
                      'ඊතැපැල් ලිපිනය',
                      emailEditMode,
                      () {
                        setState(() {
                          emailEditMode = !emailEditMode;
                        });
                      },
                      false,
                    ),
                    buildEditableField(
                      passwordController,
                      'මුරපදය',
                      passwordEditMode,
                      () {
                        setState(() {
                          passwordEditMode = !passwordEditMode;
                        });
                      },
                      true,
                    ),
                    buildEditableField(
                      addressController,
                      'ලිපිනය',
                      addressEditMode,
                      () {
                        setState(() {
                          addressEditMode = !addressEditMode;
                        });
                      },
                      false,
                    ),
                    buildEditableField(
                      contactController,
                      'දුරකථන අංකය',
                      contactEditMode,
                      () {
                        setState(() {
                          contactEditMode = !contactEditMode;
                        });
                      },
                      false,
                    ),
                    buildImageUploadButton(),
                    SizedBox(height: 16.0),
                  ],
                ),
              ),
            ),
          ),
          Center(
            child: Column(
              children: [
                const SizedBox(height: 14.0),
                SizedBox(
                  width: 150.0,
                  height: 50.0,
                  child: ElevatedButton(
                    onPressed: () {
                      updateProfile();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xaf018241),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text(
                      'යාවත්කාලීන කරන්න',
                      style: TextStyle(fontSize: 13),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(height: 45.0),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildEditableField(
    TextEditingController controller,
    String labelText,
    bool isEditMode,
    VoidCallback onEditPressed,
    bool isPassword,
  ) {
    return Padding(
      padding: EdgeInsets.only(top: 3.0, bottom: 0.0, left: 20.0, right: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                labelText,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: Icon(
                  isEditMode ? Icons.done : Icons.edit,
                  color: Color.fromARGB(255, 48, 70, 88),
                ),
                onPressed: () {
                  onEditPressed();
                  if (isEditMode) {
                    final editedValue = controller.text;
                    print('Edited value: $editedValue');
                  }
                },
              ),
            ],
          ),
          Container(
            width: 360.0,
            height: 45.0,
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
            child: TextField(
              controller: controller,
              obscureText: isPassword,
              readOnly: !isEditMode,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
          SizedBox(height: 16.0),
        ],
      ),
    );
  }

  Widget buildImageUploadButton() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 20.0, top: 16),
          child: Text(
            'පින්තුරය',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
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
                    pickImage(ImageSource.camera);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.photo),
                  onPressed: () {
                    pickImage(ImageSource.gallery);
                  },
                ),
                if (_profileImages.isNotEmpty)
                  IconButton(
                    icon: Icon(Icons.arrow_forward),
                    onPressed: switchProfileImage,
                  ),
                if (_profileImages.isNotEmpty)
                  Image.file(
                    _profileImages[_currentImageIndex],
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

  void switchProfileImage() {
    if (_profileImages.isNotEmpty) {
      setState(() {
        _currentImageIndex = (_currentImageIndex + 1) % _profileImages.length;
      });
    }
  }

  Future<void> updateProfile() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userId = user.uid;
      final updateEmail = emailController.text;
      final updatePassword = passwordController.text;
      final updatedFarmerName = farmerNameController.text;
      final updatedContact = contactController.text;
      final updatedAddress = addressController.text;

      await _farmerProfileService.updateUserProfile(
        userId,
        updateEmail,
        updatePassword,
        updatedFarmerName,
        updatedContact,
        updatedAddress,
      );

      if (_profileImages.isNotEmpty) {
        final imageUrl = await _farmerProfileService.uploadProfileImage(
          _profileImages[_currentImageIndex],
          userId,
        );

        await _farmerProfileService.updateProfileImage(userId, imageUrl);
      }
    }
  }

  Future<void> pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().getImage(source: source);
    setState(() {
      if (pickedFile != null) {
        _profileImages.add(File(pickedFile.path));
        _currentImageIndex = _profileImages.length - 1;
      }
    });
  }
}
