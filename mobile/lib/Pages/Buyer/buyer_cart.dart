import 'package:flutter/material.dart';
import 'package:mobile/Components/Buyer/favouriteCard.dart';

class BuyerCart extends StatefulWidget {
  final Map<String, dynamic> userData;
  const BuyerCart({Key? key, required this.userData}) : super(key: key);
  @override
  State<BuyerCart> createState() => _BuyerCartState();
}

class _BuyerCartState extends State<BuyerCart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("මගේ කරත්තය"),
        backgroundColor: Color.fromARGB(255, 1, 130, 65),
      ),
      body: FavouriteCard(userData: widget.userData),
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