import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FavouriteCard extends StatefulWidget {
  final Map<String, dynamic> userData;
  const FavouriteCard({required this.userData});

  @override
  State<FavouriteCard> createState() => _FavouriteCardState();
}

class _FavouriteCardState extends State<FavouriteCard> {
  List<Map<String, dynamic>> favoriteItems = [];

  @override
  void initState() {
    super.initState();
    // Fetch favorite items when the widget initializes
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

    // Refresh the UI after fetching the favorite items
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (favoriteItems.isEmpty) {
       return Center(
         child: CircularProgressIndicator(
          strokeAlign: CircularProgressIndicator.strokeAlignCenter,
         ),
       );
    }

    return ListView.builder(
      itemCount: favoriteItems.length,
      itemBuilder: (context, index) {
        final itemData = favoriteItems[index];

        // Extract data from the Firestore document
        final type = itemData['type'] ?? "Unknown";
        final amount = itemData['amount'] ?? 0.0;
        final price = itemData['price'] ?? 0.0;
        final description = itemData['description'] ?? "Unknown";
        final imageUrl = itemData['imageURL'] ?? "DefaultImageUrl";

        return FavouriteItemCard(
          type: type,
          amount: amount.toDouble(),
          price: price.toDouble(),
          description: description,
          imageUrl: imageUrl,
        );
      },
    );
  }
}

class FavouriteItemCard extends StatelessWidget {
  final String type;
  final double amount;
  final double price;
  final String description;
  final String imageUrl;

  FavouriteItemCard({
    required this.type,
    required this.amount,
    required this.price,
    required this.description,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
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
                    left: 60,top: 10
                  ),
                  child: Row(
                    children: [
                       ElevatedButton(
                        onPressed: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => ItemDetailsPage(item: item),
                          //   ),
                          // );
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
                          // Implement delete logic here
                          // You can show a confirmation dialog and delete the item if confirmed.
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
  }
}
