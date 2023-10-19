import 'package:flutter/material.dart';
import 'package:mobile/Components/Buyer/itemCard.dart';

class BuyerCart extends StatefulWidget {
  final  item;
  BuyerCart({super.key, required this.item});
  @override
  State<BuyerCart> createState() => _BuyerCartState();
}

class _BuyerCartState extends State<BuyerCart> {
  List<Item> itemsInCart = [];

  @override
  void initState() {
    super.initState();
    itemsInCart = List.from(widget.item); // Initialize the cart items list
  }

  // Method to add items to the cart
  void addItemToCart(Item item) {
    setState(() {
      itemsInCart.add(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: ListView(
        children: itemsInCart.map((item) {
          return Card(
            child: ListTile(
              leading: Image.asset(
                item.imageUrl,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
              title: Text('Item: ${item.name}'), // Display the item name
              subtitle: Text('Quantity: ${item.quantity}'), // Display the item quantity
              trailing: Text('Price: Rs.${item.price.toStringAsFixed(2)}'),
            ),
          );
        }).toList(),
      ),
    );
  }
}

// import 'package:flutter/material.dart';

// import 'package:cloud_firestore/cloud_firestore.dart';

// class BuyerCart extends StatefulWidget {
//   final String currentUserId;
//   BuyerCart({super.key, required this.currentUserId});

//   @override
//   State<BuyerCart> createState() => _BuyerCartState();
// }

// class _BuyerCartState extends State<BuyerCart> {
//   List<Map<String, dynamic>> itemsInCart = [];

//   @override
//   void initState() {
//     super.initState();
//     fetchCartItems();
//   }

//   void fetchCartItems() async {
//     FirebaseFirestore firestore = FirebaseFirestore.instance;
    
//     // Query the Firestore collection to filter documents where userId matches the current user's UID
//     QuerySnapshot cartQuery = await firestore.collection('yourCollectionName').where('userId', isEqualTo: widget.currentUserId).get();

//     // Iterate through the documents and extract cart items
//     //itemsInCart = cartQuery.docs.map((doc) => doc.data()).toList();

//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Your Cart'),
//       ),
//       body: ListView(
//         children: itemsInCart.map((item) {
//           return Card(
//             child: ListTile(
//               leading: Image.asset(
//                 item['imageUrl'],
//                 width: 50,
//                 height: 50,
//                 fit: BoxFit.cover,
//               ),
//               title: Text('Item: ${item['name']}'),
//               subtitle: Text('Quantity: ${item['quantity']}'),
//               trailing: Text('Price: Rs.${item['price'].toStringAsFixed(2)}'),
//             ),
//           );
//         }).toList(),
//       ),
//     );
//   }
// }