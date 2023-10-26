// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class BuyerProfile extends StatefulWidget {
//   final Map<String, dynamic> userData;

//   BuyerProfile({required this.userData, Key? key}) : super(key: key);

//   @override
//   _BuyerProfileState createState() => _BuyerProfileState();
// }

// class _BuyerProfileState extends State<BuyerProfile> {
//   String buyerName = '';
//   String email = '';
//   String password = '';
//   String contact = '';
//   String address = '';

//   TextEditingController buyerNameController = TextEditingController();
//   TextEditingController emailController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//   TextEditingController contactController = TextEditingController();
//   TextEditingController addressController = TextEditingController();

//   bool buyerNameEditMode = false;
//   bool emailEditMode = false;
//   bool passwordEditMode = false;
//   bool contactEditMode = false;
//   bool addressEditMode = false;

//   @override
//   void initState() {
//     super.initState();
//     final user = FirebaseAuth.instance.currentUser;
//     if (user != null) {
//       final firestore = FirebaseFirestore.instance;

//       firestore
//           .collection('buyers')
//           .where('userId', isEqualTo: user.uid)
//           .get()
//           .then((QuerySnapshot querySnapshot) {
//         if (querySnapshot.docs.isNotEmpty) {
//           final userDoc = querySnapshot.docs[0].data() as Map<String, dynamic>;

//           setState(() {
//             email = userDoc['email'] ?? '';
//             password = userDoc['password'] ?? '';
//             buyerName = userDoc['name'] ?? '';
//             contact = userDoc['contact'] ?? '';
//             address = userDoc['address'] ?? '';

//             emailController.text = email;
//             passwordController.text = password;
//             buyerNameController.text = buyerName;
//             contactController.text = contact;
//             addressController.text = address;
//           });
//         }
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     print("user: ${widget.userData}");
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           "My Profile",
//           style: TextStyle(
//             fontFamily: 'OpenSans',
//             color: Color.fromARGB(255, 61, 62, 63),
//           ),
//         ),
//        backgroundColor: Color.fromARGB(255, 1, 130, 65),
//         leading: Builder(
//           builder: (BuildContext context) {
//             return IconButton(
//               icon: const Icon(Icons.arrow_back),
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//             );
//           },
//         ),
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const SizedBox(height: 30.0),
//           Align(
//             alignment: Alignment.topCenter,
//             child: Column(
//               children: [
//                 Container(
//                   width: 100.0,
//                   height: 100.0,
//                   decoration: const BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: Color.fromARGB(255, 87, 177, 98),
//                   ),
//                   child: Center(
//                     child: Text(
//                       buyerNameController.text.isNotEmpty
//                           ? buyerNameController.text[0]
//                           : '',
//                       style: TextStyle(
//                         fontSize: 38.0,
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 15.0),
//                 Text(
//                   buyerNameController.text,
//                   style: const TextStyle(
//                     fontSize: 18.0,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             child: Container(
//               padding: EdgeInsets.only(top: 20.0),
//               child: SingleChildScrollView(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     buildEditableField(
//                       buyerNameController,
//                       'Name',
//                       buyerNameEditMode,
//                       () {
//                         setState(() {
//                           buyerNameEditMode = !buyerNameEditMode;
//                         });
//                       },
//                       false,
//                     ),
//                     buildEditableField(
//                       emailController,
//                       'Email',
//                       emailEditMode,
//                       () {
//                         setState(() {
//                           emailEditMode = !emailEditMode;
//                         });
//                       },
//                       false,
//                     ),
//                     buildEditableField(
//                       passwordController,
//                       'Password',
//                       passwordEditMode,
//                       () {
//                         setState(() {
//                           passwordEditMode = !passwordEditMode;
//                         });
//                       },
//                       true,
//                     ),
//                     buildEditableField(
//                       addressController,
//                       'Address',
//                       addressEditMode,
//                       () {
//                         setState(() {
//                           addressEditMode = !addressEditMode;
//                         });
//                       },
//                       false,
//                     ),
//                     buildEditableField(
//                       contactController,
//                       'Contact',
//                       contactEditMode,
//                       () {
//                         setState(() {
//                           contactEditMode = !contactEditMode;
//                         });
//                       },
//                       false,
//                     ),
//                     SizedBox(height: 16.0),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           Center(
//             child: Column(
//               children: [
//                 const SizedBox(height: 14.0),
//                 SizedBox(
//                   width: 150.0,
//                   height: 50.0,
//                   child: FloatingActionButton(
//                     onPressed: () {
//                       updateProfile();
//                     },
//                     backgroundColor: Color.fromARGB(255, 90, 121, 141),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(30.0),
//                     ),
//                     child: const Text(
//                       'Update',
//                       style: TextStyle(
//                         fontSize: 16.0,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 45.0),
//               ],
//             ),
//           ),
//           //FarmerNavigationBar(userData: widget.userData,),
//         ],
//       ),
//     );
//   }

//   Widget buildEditableField(
//     TextEditingController controller,
//     String labelText,
//     bool isEditMode,
//     VoidCallback onEditPressed,
//     bool isPassword,
//   ) {
//     return Padding(
//       padding: EdgeInsets.only(top: 3.0, bottom: 0.0, left: 20.0, right: 20.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 labelText,
//                 style: TextStyle(
//                   fontSize: 16.0,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               IconButton(
//                 icon: Icon(
//                   isEditMode ? Icons.done : Icons.edit,
//                   color: Color.fromARGB(255, 48, 70, 88),
//                 ),
//                 onPressed: () {
//                   onEditPressed();
//                   if (isEditMode) {
//                     final editedValue = controller.text;
//                     print('Edited value: $editedValue');
//                   }
//                 },
//               ),
//             ],
//           ),
//           Container(
//             width: 360.0,
//             height: 45.0,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10.0),
//               color: Colors.white,
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.grey.withOpacity(0.5),
//                   spreadRadius: 2,
//                   blurRadius: 5,
//                   offset: Offset(0, 2),
//                 ),
//               ],
//             ),
//             child: TextField(
//               controller: controller,
//               obscureText: isPassword,
//               readOnly: !isEditMode,
//               decoration: InputDecoration(
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10.0),
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(height: 16.0),
//         ],
//       ),
//     );
//   }

//   Future<void> updateProfile() async {
//     final user = FirebaseAuth.instance.currentUser;
//     if (user != null) {
//       final userId = user.uid;
//       final firestore = FirebaseFirestore.instance;

//       final updateEmail = emailController.text;
//       final updatePassword = passwordController.text;
//       final updatedSupplierName = buyerNameController.text;
//       final updatedContact = contactController.text;
//       final updatedAddress = addressController.text;

//       final userDocsQuery = firestore
//           .collection('buyers')
//           .where('userId', isEqualTo: userId);

//       final userDocsSnapshot = await userDocsQuery.get();

//       if (userDocsSnapshot.docs.isNotEmpty) {
//         final userDocRef = userDocsSnapshot.docs[0].reference;

//         await userDocRef.update({
//           'email': updateEmail,
//           'password': updatePassword,
//           'supplierName': updatedSupplierName,
//           'contact': updatedContact,
//           'address': updatedAddress,
//         });
//       } else {
//         print('Error: Document for user does not exist.');
//       }
//     }
//   }
// }





import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io' ;
import 'package:firebase_storage/firebase_storage.dart';

class BuyerProfile extends StatefulWidget {
  final Map<String, dynamic> userData;

  BuyerProfile({required this.userData, Key? key}) : super(key: key);

  @override
  _BuyerProfileState createState() => _BuyerProfileState();
}

class _BuyerProfileState extends State<BuyerProfile> {
  String buyerName = '';
  String email = '';
  String password = '';
  String contact = '';
  String address = '';
  String profileImageURL = '';

  TextEditingController buyerNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  bool buyerNameEditMode = false;
  bool emailEditMode = false;
  bool passwordEditMode = false;
  bool contactEditMode = false;
  bool addressEditMode = false;

  List<File> _profileImages = [];
  int _currentImageIndex = 0;

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final firestore = FirebaseFirestore.instance;

      firestore
          .collection('buyers')
          .where('userId', isEqualTo: user.uid)
          .get()
          .then((QuerySnapshot querySnapshot) {
        if (querySnapshot.docs.isNotEmpty) {
          final userDoc = querySnapshot.docs[0].data() as Map<String, dynamic>;

          setState(() {
            email = userDoc['email'] ?? '';
            password = userDoc['password'] ?? '';
            buyerName = userDoc['buyerName'] ?? '';
            contact = userDoc['contact'] ?? '';
            address = userDoc['address'] ?? '';
            profileImageURL = userDoc['profileImageURL'] ?? '';

            emailController.text = email;
            passwordController.text = password;
            buyerNameController.text = buyerName;
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
        title: const Text("My Profile"),
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
                              buyerNameController.text.isNotEmpty
                                  ? buyerNameController.text[0]
                                  : '',
                              style: TextStyle(
                                fontSize: 38.0,
                                color: Color.fromARGB(255, 3, 165, 76),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                  ),
                ),
                const SizedBox(height: 15.0),
                Text(
                  buyerNameController.text,
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
                      buyerNameController,
                      'Name',
                      buyerNameEditMode,
                      () {
                        setState(() {
                          buyerNameEditMode = !buyerNameEditMode;
                        });
                      },
                      false,
                    ),
                    buildEditableField(
                      emailController,
                      'Email',
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
                      'Password',
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
                      'Address',
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
                      'Contact',
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
                  child: FloatingActionButton(
                    onPressed: () {
                      updateProfile();
                    },
                    backgroundColor: Color.fromARGB(255, 90, 121, 141),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: const Text(
                      'Update',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
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
          padding: EdgeInsets.only(left: 20.0),
          child: Text(
            'Profile Image',
            style: TextStyle(
              fontSize: 18.0,
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
                    _pickImage(ImageSource.camera);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.photo),
                  onPressed: () {
                    _pickImage(ImageSource.gallery);
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
                  Text("No image selected"),
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
      final firestore = FirebaseFirestore.instance;

      final updateEmail = emailController.text;
      final updatePassword = passwordController.text;
      final updatedFarmerName = buyerNameController.text;
      final updatedContact = contactController.text;
      final updatedAddress = addressController.text;

      final userDocsQuery =
          firestore.collection('buyers').where('userId', isEqualTo: userId);

      final userDocsSnapshot = await userDocsQuery.get();

      if (userDocsSnapshot.docs.isNotEmpty) {
        final userDocRef = userDocsSnapshot.docs[0].reference;

        await userDocRef.update({
          'email': updateEmail,
          'password': updatePassword,
          'buyerName': updatedFarmerName,
          'contact': updatedContact,
          'address': updatedAddress,
        });

        if (_profileImages.isNotEmpty) {
          final imageUrl = await _uploadProfileImage(
            _profileImages[_currentImageIndex],
            userId,
          );

          await userDocRef.update({
            'profileImageURL': imageUrl,
          });
        }
      }
    }
  }

  Future<String> _uploadProfileImage(File image, String userId) async {
    final Reference storageRef = FirebaseStorage.instance
        .ref()
        .child('profile_images/$userId/${DateTime.now()}.jpg');

    final UploadTask uploadTask = storageRef.putFile(image);

    try {
      await uploadTask;
      final imageUrl = await storageRef.getDownloadURL();
      return imageUrl;
    } catch (e) {
      print('Error uploading profile image: $e');
      throw e;
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().getImage(source: source);
    setState(() {
      if (pickedFile != null) {
        _profileImages.add(File(pickedFile.path));
        _currentImageIndex = _profileImages.length - 1;
      }
    });
  }
}

