import 'package:flutter/material.dart';
import 'package:mobile/Pages/Buyer/item_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobile/Services/FarmerServices/alert_services.dart';

class ItemCard extends StatefulWidget {
  final Map<String, dynamic> userData;
  final String selectedTypeName;
  final String searchTypeName;
  const ItemCard({required this.userData, required this.selectedTypeName,required this.searchTypeName,});
  @override
  _ItemCardState createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  // Initialize an empty list to store items from Firestore
  List<Item> items = [];
  
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


  // Function to fetch items from Firestore
  Future<void> fetchItemsFromFirestore() async {
    try {
      final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('published_harvest')
          .get();

      final List<Item> fetchedItems = [];

      querySnapshot.docs.forEach((doc) {
        final userId = doc['userid'] as String;
        final itemsList = doc['items'] as List<dynamic>;

        // Extract items from the itemsList and add them to the fetchedItems list
        itemsList.forEach((itemData) {
          final type = itemData['type'] ?? "Unknown";
          final amount = (itemData['amount'] as num?)?.toDouble() ?? 0.0;
          final price = (itemData['price'] as num?)?.toDouble() ?? 0.0;
          final description = itemData['description'] ?? "Unknown";
          final imageUrl = itemData['imageURL'] ?? "DefaultImageUrl";

          print('type:${widget.selectedTypeName}');
          print('type:${widget.searchTypeName}');
          if (widget.selectedTypeName == type) {
            fetchedItems
                .add(Item(type, imageUrl, amount, price, description, userId));
          }
          else if (widget.searchTypeName == type){
          fetchedItems
              .add(Item(type, imageUrl, amount, price, description, userId));
          }
          else if (widget.selectedTypeName == '' && widget.searchTypeName == ''){
          fetchedItems
              .add(Item(type, imageUrl, amount, price, description, userId));
          }
        });
      });

      // Update the state to populate the items list
      setState(() {
        items = fetchedItems;
        print('fetched:$fetchedItems');
      });
    } catch (e) {
      print("Error fetching items from Firestore: $e");
    }
  }

  Future<void> addToFavorites(Item item) async {
    try {
      final CollectionReference favoritesCollection =
          FirebaseFirestore.instance.collection('favorites');

      // Define the data you want to add to the favorites collection
      final Map<String, dynamic> favoriteData = {
        'type': item.type,
        'amount': item.amount,
        'price': item.price,
        'description': item.description,
        'imageURL': item.imageUrl,
        'userId': item.userId,
      };

      // Create a reference to the user's document in the 'favorites' collection
      final DocumentSnapshot userDoc =
          await favoritesCollection.doc(widget.userData['uid']).get();

      // Check if the user document already exists
      //final DocumentSnapshot userDocSnapshot = await userDoc.get();

      if (userDoc.exists) {
        // User document exists, update the 'favorite_items' array
        await favoritesCollection.doc(widget.userData['uid']).update({
          'favorite_items': FieldValue.arrayUnion([favoriteData]),
        });
      } else {
        // User document doesn't exist, create a new one
        await favoritesCollection.doc(widget.userData['uid']).set({
          'userId': widget.userData['uid'],
          'favorite_items': [favoriteData],
        });
      }
      await showCustomAlertDialog(
              context: context,
              title: 'සාර්ථකයි',
              message: 'අයිතමය සාර්ථකව කරත්තයට එකතු කරන ලදී',
              buttonText: 'හරි',
              onButtonPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              isSuccess: true,
            );
      
    } catch (e) {
      print("Error adding item to favorites: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    // Fetch items from Firestore when the widget initializes
    fetchItemsFromFirestore();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.78,
        mainAxisSpacing: 10,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return Container(
          padding: EdgeInsets.all(12.0),
          child: Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 136,
                  child: Image.network(
                    item.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 8.0,
                    right: 8.0,
                    top: 5.0,
                    //bottom: 3.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${item.amount.toStringAsFixed(2)} Kg',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff000000),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          // When the cart icon is clicked, add the item to favorites
                          await addToFavorites(item);
                        },
                        child: Icon(Icons.shopping_cart),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 8.0,
                    right: 8.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'රු.${item.price.toStringAsFixed(2)}', // Use the quantity from the item
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff000000),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ItemDetailsPage(item: item),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xaf018241),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          minimumSize: Size(0, 28),
                        ),
                        child: Text(
                          'බලන්න',
                          style: TextStyle(
                            fontFamily: 'Iskoola Pota',
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color(0xffffffff),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class Item {
  final String type;
  final String imageUrl;
  final double amount;
  final double price;
  final String description;
  final String userId;

  Item(this.type, this.imageUrl, this.amount, this.price, this.description,
      this.userId);
}
