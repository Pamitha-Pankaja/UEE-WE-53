import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FarmerProfileService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> updateUserProfile(
    String userId,
    String email,
    String password,
    String farmerName,
    String contact,
    String address,
  ) async {
    final userDocsQuery = _firestore.collection('farmers').where('userId', isEqualTo: userId);
    final userDocsSnapshot = await userDocsQuery.get();

    if (userDocsSnapshot.docs.isNotEmpty) {
      final userDocRef = userDocsSnapshot.docs[0].reference;

      await userDocRef.update({
        'email': email,
        'password': password,
        'farmerName': farmerName,
        'contact': contact,
        'address': address,
      });
    }
  }

  Future<String> uploadProfileImage(File image, String userId) async {
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

  Future<void> updateProfileImage(String userId, String imageUrl) async {
    final userDocsQuery = _firestore.collection('farmers').where('userId', isEqualTo: userId);
    final userDocsSnapshot = await userDocsQuery.get();

    if (userDocsSnapshot.docs.isNotEmpty) {
      final userDocRef = userDocsSnapshot.docs[0].reference;

      await userDocRef.update({
        'profileImageURL': imageUrl,
      });
    }
  }
  
  Future<Map<String, dynamic>> getUserProfile() async {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final user = _auth.currentUser;

  if (user == null) {
    return Map<String, dynamic>(); // Return an empty map if the user is not logged in.
  }

  final querySnapshot = await _firestore
      .collection('farmers')
      .where('userId', isEqualTo: user.uid)
      .get();

  if (querySnapshot.docs.isNotEmpty) {
    final userDoc = querySnapshot.docs[0].data() as Map<String, dynamic>;

    final farmerName = userDoc['farmerName'] ?? '';
    final password = userDoc['password'] ?? '';
    final email = userDoc['email'] ?? '';
    final contact = userDoc['contact'] ?? '';
    final profileImageURL = userDoc['profileImageURL'] ?? '';
    final address = userDoc['address'] ?? '';

    return {
      'farmerName': farmerName,
      'password': password,
      'email': email,
      'contact': contact,
      'profileImageURL': profileImageURL,
      'address': address,
    };
  } else {
    return Map<String, dynamic>();
  }
}


}
