import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobile/Services/FarmerServices/alert_services.dart';

class HarvestCard extends StatefulWidget {
  final Map<String, dynamic> userData;
  const HarvestCard({required this.userData});

  @override
  State<HarvestCard> createState() => _HarvestCardState();
}

class _HarvestCardState extends State<HarvestCard> {
  List<Map<String, Object>> filteredItems = [];
  void deleteItem(context, index) async {
    final firestore = FirebaseFirestore.instance;
    final userId = widget.userData['uid'];

    await firestore
        .collection('published_harvest')
        .where('userid', isEqualTo: userId)
        .get()
        .then((querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        final userDocRef = querySnapshot.docs[0].reference;
        List<dynamic> currentItems = querySnapshot.docs[0]['items'];

        // Remove the item at the specified index
        currentItems.removeAt(index);

        // Update the entire 'items' array with the modified array
        userDocRef.update({'items': currentItems});
        setState(() {
          filteredItems.removeAt(index);
        });
      } else {
        // Handle the case where the user's document doesn't exist
        print('User document does not exist');
      }
    });
  }

  void editItemDetailsDialog(
      BuildContext context, Map<String, dynamic> itemData, int itemIndex) {
    TextEditingController typeController =
        TextEditingController(text: itemData['type'] as String);
    TextEditingController descriptionController =
        TextEditingController(text: itemData['description'] as String);
    TextEditingController imageController =
        TextEditingController(text: itemData['imageURL'] as String);
    TextEditingController priceController =
        TextEditingController(text: itemData['price'].toString());
    TextEditingController amountController =
        TextEditingController(text: itemData['amount'].toString());

    final userId = widget.userData['uid'];

    ScaffoldMessenger.of(context)
        .removeCurrentSnackBar(); // Remove any existing snack bar.
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('යාවත්කාලීන කරන්න:'),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                // Add input fields for editing item details
                TextFormField(
                  controller: typeController,
                  decoration: InputDecoration(labelText: 'බෝග වර්ගය'),
                ),
                TextFormField(
                  controller: descriptionController,
                  decoration: InputDecoration(labelText: 'විස්තර'),
                ),
                TextFormField(
                  controller: priceController,
                  decoration: InputDecoration(labelText: 'මිල (1kg සඳහා)'),
                ),
                TextFormField(
                  controller: amountController,
                  decoration: InputDecoration(labelText: 'අස්වැන්න ප්‍රමාණය'),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () async {
                final updatedItem = {
                  'type': typeController.text,
                  'description': descriptionController.text,
                  'price': double.parse(priceController.text),
                  'amount': double.parse(amountController.text),
                  'imageURL': imageController.text,
                };

                final firestore = FirebaseFirestore.instance;

                await firestore
                    .collection('published_harvest')
                    .where('userid', isEqualTo: userId)
                    .get()
                    .then((querySnapshot) {
                  if (querySnapshot.docs.isNotEmpty) {
                    final userDocRef = querySnapshot.docs[0].reference;
                    List<dynamic> currentItems = querySnapshot.docs[0]['items'];

                    currentItems[itemIndex] = updatedItem;

                    userDocRef.update({'items': currentItems}).then((_) {
                      showCustomAlertDialog(
                        context: context,
                        title: 'සාර්ථකයි',
                        message: 'අයිතමය සාර්ථකව යාවත්කාලීන කරන ලදී',
                        buttonText: 'හරි',
                        onButtonPressed: () {
                          Navigator.of(context).pop(); // Close the dialog
                        },
                        isSuccess: true,
                      );
                      setState(() {
                        filteredItems[itemIndex] = updatedItem;
                      });
                      Navigator.of(context).pop(); // Close the dialog
                    }).catchError((error) {
                      print('Error updating item: $error');
                      showCustomAlertDialog(
                        context: context,
                        title: 'අසාර්ථකයි',
                        message: 'සියලුම ක්ෂේත්‍ර පිරවිය යුතුයි.',
                        buttonText: 'අවලංගු කරන්න',
                        isSuccess: false,
                        onButtonPressed: () {
                          Navigator.of(context).pop(); // Close the dialog
                        },
                      );
                    });
                  } else {
                    // Handle the case where the user's document doesn't exist
                    print('User document does not exist');
                  }
                });
              },
              child: Text('යාවත්කාලීන කරන්න'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog without saving
              },
              child: Text('අවලංගු කරන්න'),
            ),
          ],
        );
      },
    );
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

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('published_harvest')
          .doc(widget.userData['uid']) // Assuming 'uid' is the document ID
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        if (!snapshot.hasData || snapshot.data?.data() == null) {
          return Text("No data available.");
        }

        final documentData = snapshot.data?.data() as Map<String, dynamic>;

        if (documentData['items'] == null) {
          return Text("No items available.");
        }

        final items = documentData['items'] as List<dynamic>;

        return ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            final itemData = items[index] as Map<String, dynamic>;

            // Extract data from the Firestore document
            final type = itemData['type'] ?? "Unknown";
            final amount = itemData['amount'] ?? 0.0;
            final price = itemData['price'] ?? 0.0;
            final description = itemData['description'] ?? "Unknown";
            final imageUrl = itemData['imageURL'] ?? "DefaultImageUrl";

            return Card(
              margin: EdgeInsets.all(10),
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                    ),
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      height: 155,
                      width: 150,
                      scale: 1,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, left: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          type,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          '$amount Kg',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          'රු.${price.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          '$description',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey,
                          ),
                        ),
                        // Add edit and delete icons here
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 100,
                          ),
                          child: Row(
                            children: [
                              IconButton(
                                icon: Icon(
                                  Icons.edit,
                                  size: 30,
                                  color: const Color.fromARGB(255, 0, 50, 90),
                                ),
                                onPressed: () {
                                  editItemDetailsDialog(
                                      context, itemData, index);
                                },
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.delete,
                                  size: 30,
                                  color: const Color.fromARGB(255, 175, 15, 3),
                                ),
                                onPressed: () {
                                  deleteItem(context, index);
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}







// class CustomHarvestCard extends StatelessWidget {
//   final String type;
//   final int amount;
//   final int price;
//   final String imageUrl;

//   CustomHarvestCard({
//     required this.type,
//     required this.amount,
//     required this.price,
//     required this.imageUrl,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: EdgeInsets.all(10),
//       elevation: 3,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(15),
//       ),
//       child: Column(
//         children: <Widget>[
//           ClipRRect(
//             borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(15),
//               topRight: Radius.circular(15),
//             ),
//             child: Image.network(
//               imageUrl,
//               fit: BoxFit.cover,
//               height: 200,
//               width: double.infinity,
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 Text(
//                   type,
//                   style: TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.w700,
//                     color: Colors.black,
//                   ),
//                 ),
//                 SizedBox(height: 5),
//                 Text(
//                   'Total Harvest: $amount Kg',
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w400,
//                     color: Colors.grey,
//                   ),
//                 ),
//                 Text(
//                   'Price (1Kg): Rs. $price/=',
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w400,
//                     color: Colors.grey,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
