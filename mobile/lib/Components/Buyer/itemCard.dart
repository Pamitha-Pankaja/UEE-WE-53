import 'package:flutter/material.dart';
import 'package:mobile/Pages/Buyer/item_details.dart';
//import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Authentication

class ItemCard extends StatefulWidget {
  @override
  _ItemCardState createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  final List<Item> items = [
    Item('තක්කාලි', 'assets/item1.png', '2500kg', 500.0),
    Item('කැරට්', 'assets/item2.png', '2000kg', 750.0),
    Item('බඩ ඉරිඟු', 'assets/item3.png', '1500kg', 650.0),
    Item('තක්කාලි', 'assets/item4.png', '6000kg', 500.0),
    Item('වට්ටක්කා', 'assets/item5.png', '1800kg', 450.0),
    Item('අල', 'assets/item6.png', '4000kg', 350.0),
    Item('අමුමිරිස්', 'assets/item7.png', '2300kg', 250.0),
    Item('රාබු', 'assets/item8.png', '1000kg', 500.0),
    // Add more items here
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Number of items in each row
        childAspectRatio: 0.8, // Adjust this value to control card width
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index]; // Get the current item
        return Container(
         // width: 200, // Set the desired width
         // height: 500, // Set the desired height
          padding: EdgeInsets.all(12.0),
          child: Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 136,
                  child: Image.asset(
                    item.imageUrl, // Use the imageUrl from the item
                    width: 50,
                    height: 50,
                    scale: 0.1,
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
                        item.quantity, // Use the quantity from the item
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff000000),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          // Add the selected item to the user's cart in Firestore
                          // User? user =_auth.currentUser; // Get the current user
                          // if (user != null) {
                          //   await _cartCollection
                          //       .doc(user
                          //           .uid) // Use the user's UID as the document ID
                          //       .collection('items')
                          //       .add({
                          //     'name': item.name,
                          //     'imageUrl': item.imageUrl,
                          //     'quantity': item.quantity,
                          //     'price': item.price,
                          //   });
                          // }
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
                        'Rs.${item.price.toStringAsFixed(2)}', // Use the quantity from the item
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
                          minimumSize: Size(0, 20),
                        ),
                        child: Text(
                          'බලන්න',
                          style: TextStyle(
                            fontFamily: 'Iskoola Pota',
                            fontSize: 10,
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
  final String name;
  final String imageUrl;
  final String quantity;
  final double price;

  Item(this.name, this.imageUrl, this.quantity, this.price);
}
