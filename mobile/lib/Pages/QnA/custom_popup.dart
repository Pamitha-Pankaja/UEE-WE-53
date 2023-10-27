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

    // Function to create a styled text with margin at the top and bottom, aligned to the left
    Widget buildTextWithMargin(String text) {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 8.0), // Add margin to the top and bottom
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            text,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      );
    }

    return AlertDialog(
      title: Text("Add a Question"),
      content: Container(
        width: screenWidth * 0.8, // Set the width to match the screen width
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            buildTextWithMargin("Question Topic:"), // Add margin and align to the left
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
            buildTextWithMargin("Question Description:"), // Add margin and align to the left
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
            buildTextWithMargin("Crop Type:"), // Add margin and align to the left
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
            buildTextWithMargin("Upload Images:"), // Add margin and align to the left
            buildInputBox(
              ElevatedButton(
                onPressed: () {
                  // Implement image upload logic here
                },
                child: Text("Upload Images"),
              ),
            ),
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
