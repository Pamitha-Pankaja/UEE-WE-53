import 'package:flutter/material.dart';

class CustomDialog extends StatefulWidget {
  @override
  _CustomDialogState createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  final TextEditingController _topicController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String _selectedCrop = 'Pumpkin'; // Default crop type
  List<String> _cropTypes = ['Pumpkin', 'Tomato', 'Other']; // List of crop types

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Function to create a styled input box
    Widget buildInputBox(Widget child) {
      return Container(
        width: screenWidth * 0.8, // Set the width to match the screen width
        decoration: BoxDecoration(
          color: Colors.grey[200], // Light color for the box
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey, // Shadow color
              offset: Offset(0, 2), // Offset of the shadow
              blurRadius: 3, // Spread of the shadow
            ),
          ],
        ),
        child: child,
      );
    }

    return AlertDialog(
      title: Text("Add a Question"),
      content: Container(
        width: screenWidth * 0.8, // Set the width to match the screen width
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Question Topic:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            buildInputBox(
              TextField(
                controller: _topicController,
                decoration: InputDecoration(
                  hintText: "Enter your question topic",
                  border: InputBorder.none, // Remove default border
                  contentPadding: EdgeInsets.all(8.0),
                ),
              ),
            ),
            SizedBox(height: 16),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Question Description:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            buildInputBox(
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  hintText: "Enter your question description",
                  border: InputBorder.none, // Remove default border
                  contentPadding: EdgeInsets.all(8.0),
                ),
              ),
            ),
            SizedBox(height: 16),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Crop Type:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: buildInputBox(
                Container(
                  width: double.infinity, // Set the width to match the container
                  child: DropdownButton<String>(
                    value: _selectedCrop,
                    items: _cropTypes.map((String crop) {
                      return DropdownMenuItem<String>(
                        value: crop,
                        child: Text(crop),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedCrop = newValue!;
                      });
                    },
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Upload Images:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            buildInputBox(
              ElevatedButton(
                onPressed: () {
                  // Implement image upload logic here
                },
                child: Text("Upload Images"),
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    // Add logic to handle the submission of the question here
                    final topic = _topicController.text;
                    final description = _descriptionController.text;

                    if (topic.isNotEmpty) {
                      // Close the dialog and process the entered data
                      Navigator.of(context).pop();
                      // You can use topic, description, _selectedCrop, and uploaded images for further processing.
                    }
                  },
                  child: Text("Submit"),
                ),
                TextButton(
                  onPressed: () {
                    // Close the dialog without processing the input
                    Navigator.of(context).pop();
                  },
                  child: Text("Cancel"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


