import 'package:flutter/material.dart';

class ItemDetailsPage extends StatefulWidget {
  final item;

  ItemDetailsPage({required this.item});

  @override
  _ItemDetailsPageState createState() => _ItemDetailsPageState();
}

class _ItemDetailsPageState extends State<ItemDetailsPage> {
  @override
  Widget build(BuildContext context) {
    print(widget.item);
    return Scaffold(
      appBar: AppBar(
        title: Text('වැඩිපුර විස්තර'),
         backgroundColor: Color.fromARGB(255, 1, 130, 65),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
            Image.asset(
              widget.item.imageUrl,
              width: 100,
              height: 100,
              scale: 1,
              fit: BoxFit.cover,
            ),
            Text('Name: ${widget.item.name}'),
            Text('Quantity: ${widget.item.quantity}'),
            Text('Price: Rs.${widget.item.price.toStringAsFixed(2)}'),
          ],
        ),
      ),
    );
  }
}
