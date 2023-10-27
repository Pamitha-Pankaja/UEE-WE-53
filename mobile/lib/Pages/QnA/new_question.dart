import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobile/Pages/QnA/farmer_qna.dart';

class AddQuestion extends StatefulWidget {
  @override
  _AddQuestionState createState() => _AddQuestionState();
}

class _AddQuestionState extends State<AddQuestion> {
  final TextEditingController _topicController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String _selectedCrop = 'සහල්'; // Default crop type
  final List<String> _cropTypes = [
    'වට්ටක්කා',
    'අමු මිරිස්',
    'තක්කාලි',
    'සහල්',
    'වම්බටු',
    'මුං ඇට',
    'බණ්ඩක්කා',
    'ගෝවා',
    'අර්තාපල්',
    'කැරට්',
    'ලීක්ස්',
    'ළූණු',
    'සුදුළූණු',
  ]; // List of crop types
  XFile? _image; // Variable to store the selected image file

  BoxDecoration inputBoxDecoration = BoxDecoration(
    color: Colors.white, // Light color for the box
    borderRadius: BorderRadius.circular(8.0),
    boxShadow: [
      BoxShadow(
        color: Colors.grey, // Shadow color
        offset: Offset(0, 2), // Offset of the shadow
        blurRadius: 3, // Spread of the shadow
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ප්‍රශ්නයක් එක් කරන්න"),
        backgroundColor: Color.fromARGB(255, 42, 175, 46),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          color: Color.fromARGB(255, 234, 240, 233),
          child: Center(
            child: Column(
              children: [
                buildInputField(
                  labelText: "ප්‍රශ්න මාතෘකාව",
                  child: TextField(
                    controller: _topicController,
                    decoration: InputDecoration(
                      hintText: "ඔබේ ප්‍රශ්න මාතෘකාව ඇතුළත් කරන්න",
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(8.0),
                    ),
                    maxLines: null, // Allow the TextField to expand vertically
                  ),
                ),
                SizedBox(height: 20), // Add spacing between input fields
                buildInputField(
                  labelText: "ප්‍රශ්න විස්තරය",
                  child: TextField(
                    controller: _descriptionController,
                    decoration: InputDecoration(
                      hintText: "ඔබගේ ප්‍රශ්න විස්තරය ඇතුලත් කරන්න",
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(8.0),
                    ),
                    maxLines: null, // Allow the TextField to expand vertically
                  ),
                ),

                SizedBox(height: 20), // Add spacing between input fields
                buildInputField(
                  labelText: "බෝග වර්ගය",
                  child: DropdownButtonFormField<String>(
                    value: _selectedCrop,
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedCrop = newValue!;
                      });
                    },
                    items: _cropTypes.map((String crop) {
                      return DropdownMenuItem<String>(
                        value: crop,
                        child: Text(crop),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(height: 20), // Add spacing between input fields
                buildInputField(
                  labelText: "පින්තූර තෝරන්න",
                  child: ElevatedButton(
                    onPressed: _pickImage,
                    style: ElevatedButton.styleFrom(
                      primary:
                          Colors.white, // Set button background color to white
                      onPrimary: Colors.black, // Set text color to black
                      minimumSize: Size(double.infinity, 50),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.cloud_upload,
                            color: Colors.black), // Upload icon
                        SizedBox(
                            width:
                                8), // Add some spacing between the icon and text
                        Text(
                          _image == null ? "තෝරන්න" : "රූපය තෝරන ලදී",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                if (_image != null)
                  kIsWeb
                      ? Image.network(_image!
                          .path) // Display the selected image using Image.network on web
                      : Image.file(File(_image!
                          .path)), // Display the selected image using Image.file on mobile
                SizedBox(height: 20), // Add spacing between input fields
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        // Add logic to handle the submission of the question here
                        final topic = _topicController.text;
                        final description = _descriptionController.text;

                        print('#########################################');

                        if (topic.isNotEmpty && description.isNotEmpty) {
                          try {
                            // Access the Firebase Firestore instance
                            FirebaseFirestore firestore =
                                FirebaseFirestore.instance;

                            // Create a new document in the "questions and answers" collection
                            DocumentReference documentReference =
                                await firestore
                                    .collection('questions_and_answers')
                                    .add({
                              'questionTopic': topic,
                              'questionDescription': description,
                              'cropType': _selectedCrop,
                              'author':
                                  '11001100', // Replace with the actual author ID or logic to obtain it
                              'answer': "",
                            });

                            if (_image != null) {
                              FirebaseStorage storage =
                                  FirebaseStorage.instance;
                              Reference storageReference = storage.ref().child(
                                  'question_images/${documentReference.id}');
                              UploadTask uploadTask =
                                  storageReference.putFile(File(_image!.path));

                              await uploadTask;
                              String imageUrl =
                                  await storageReference.getDownloadURL();

                              // Now you can update the Firestore document with the image URL
                              await documentReference.update({
                                'image': imageUrl,
                              });

                              // Show success message in a toast
                              Fluttertoast.showToast(
                                msg: 'ප්‍රශ්නය සාර්ථකව ප්‍රකාශයට පත් විය!',
                                gravity: ToastGravity.CENTER,
                                backgroundColor: Colors.green,
                              );

                              // Navigate to the QnAPage after a successful publish
                              Navigator.of(context).pop();
                            }
                          } catch (error) {
                            // Handle errors and show an error toast message
                            Fluttertoast.showToast(
                              msg: 'දෝෂයකි: $error',
                              gravity: ToastGravity.CENTER,
                              backgroundColor: Colors.red,
                            );
                            print("දෝෂයකි: $error");
                          }
                        } else {
                          // Show a validation error message
                          Fluttertoast.showToast(
                            msg: 'කරුණාකර අවශ්‍ය සියලුම දත්ත පුරවන්න',
                            gravity: ToastGravity.CENTER,
                            backgroundColor: Colors.orange,
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green, // Set button color to green
                      ),
                      child: Text("ප්‍රකාශ කරන්න"),
                    ),
                    SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: () {
                        // Close the page without processing the input
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red, // Set button color to red
                      ),
                      child: Text("අවලංගු කරන්න"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _image = image;
      });
    }
  }

  Widget buildInputField({
    required String labelText,
    required Widget child,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        Container(
          decoration: inputBoxDecoration,
          child: child,
        ),
      ],
    );
  }
}

void main() {
  runApp(
    MaterialApp(
      home: AddQuestion(),
    ),
  );
}
