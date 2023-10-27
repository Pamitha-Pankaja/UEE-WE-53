import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class ImageUploadPage extends StatefulWidget {
  @override
  _ImageUploadPageState createState() => _ImageUploadPageState();
}

class _ImageUploadPageState extends State<ImageUploadPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final ImagePicker _imagePicker = ImagePicker();
  String imageUrl = "";
  String hardcodedUid = "your_hardcoded_uid";

  Future<void> uploadImage() async {
    if (hardcodedUid.isEmpty) {
      Fluttertoast.showToast(msg: "Please set the hardcoded UID");
      return;
    }

    final imageFile = await _imagePicker.pickImage(source: ImageSource.gallery);

    if (imageFile == null) return;

    final storageRef = _storage.ref().child('images/$hardcodedUid/${DateTime.now()}.png');

    if (kIsWeb) {
      final blob = await imageFile.readAsBytes();
      final uploadTask = storageRef.putData(blob);

      try {
        await uploadTask;
      } catch (e) {
        print("Error uploading image: $e");
        Fluttertoast.showToast(msg: "Image upload failed");
        return;
      }
    } else {
      final file = await imageFile.readAsBytes();
      final uploadTask = storageRef.putData(file);

      try {
        await uploadTask;
      } catch (e) {
        print("Error uploading image: $e");
        Fluttertoast.showToast(msg: "Image upload failed");
        return;
      }
    }

    final downloadUrl = await storageRef.getDownloadURL();
    await _firestore.collection('images').add({
      'userId': hardcodedUid,
      'imageUrl': downloadUrl,
      'timestamp': FieldValue.serverTimestamp(),
    });

    setState(() {
      imageUrl = downloadUrl;
    });

    Fluttertoast.showToast(msg: "Image uploaded successfully");
  }

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Upload'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            imageUrl != ""
                ? Image.network(
                    imageUrl,
                    scale: 1,
                    loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      } else {
                        return CircularProgressIndicator();
                      }
                    },
                    errorBuilder: (context, error, stackTrace) {
                      // Display a user-friendly error message
                      print("Image load error: $error");
                      return Text("Image load failed. Please try again.");
                    },
                  )
                : Image.asset("assets/corn.png"), // Add a placeholder image
            ElevatedButton(
              onPressed: uploadImage,
              child: Text("Upload Image"),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(home: ImageUploadPage()));
}
