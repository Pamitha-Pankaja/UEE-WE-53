import 'package:flutter/material.dart';
import 'package:mobile/Pages/Buyer/item_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FavouriteCard extends StatefulWidget {
  final Map<String, dynamic> userData;
  FavouriteCard({
    required this.userData,
  });

  @override
  _FavouriteCardState createState() => _FavouriteCardState();
}

class _FavouriteCardState extends State<FavouriteCard> {
  List<Map<String, dynamic>> favoriteItems = [];

  @override
  void initState() {
    super.initState();
    _fetchFavoriteItems();
  }

  Future<void> _fetchFavoriteItems() async {
    try {
      final DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('favorites')
          .doc(widget.userData['uid'])
          .get();

      if (snapshot.exists) {
        final documentData = snapshot.data() as Map<String, dynamic>;
        final favoriteItemsData =
            documentData['favorite_items'] as List<dynamic>;
        favoriteItems = List<Map<String, dynamic>>.from(favoriteItemsData);
      }
    } catch (e) {
      print("Error fetching favorite items: $e");
    }

    setState(() {});
  }

  void deleteItem(BuildContext context, int index) {
  final itemData = favoriteItems[index];
  final userId = widget.userData['uid'];

  // Delete the item from Firestore
  FirebaseFirestore.instance
      .collection('favorites')
      .doc(userId)
      .update({
        'favorite_items': FieldValue.arrayRemove([itemData])
      })
      .then((_) {
    // Item deleted successfully, now remove it from the local list
    setState(() {
      favoriteItems.removeAt(index);
    });
  })
      .catchError((error) {
    print("Error deleting item: $error");
    // Handle the error as needed
  });
}


  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: favoriteItems.length,
      itemBuilder: (context, index) {
        final itemData = favoriteItems[index];

        final type = itemData['type'] ?? "Unknown";
        final amount = itemData['amount'] ?? 0.0;
        final price = itemData['price'] ?? 0.0;
        final description = itemData['description'] ?? "Unknown";
        final imageUrl = itemData['imageURL'] ?? "DefaultImageUrl";
        final farmerId = itemData['userId'];

        return Card(
          margin: EdgeInsets.all(16),
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
                      '${amount.toStringAsFixed(2)} Kg',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      '${price.toStringAsFixed(2)}/=',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 60, top: 10),
                      child: Row(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ItemDetailsPage(
                                      item: Item(
                                    type,
                                    imageUrl,
                                    amount,
                                    price,
                                    description,
                                    farmerId,
                                  )),
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
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color(0xffffffff),
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete,
                                size: 27, color: Color(0xFFAF0F03)),
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
