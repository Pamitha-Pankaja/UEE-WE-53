import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class ItemDetailsPage extends StatefulWidget {
  final item;
  ItemDetailsPage({required this.item});

  @override
  _ItemDetailsPageState createState() => _ItemDetailsPageState();
}

class _ItemDetailsPageState extends State<ItemDetailsPage> {
  late Map<String, dynamic> userData;

  late Future<void> userDataFuture;

  @override
  void initState() {
    super.initState();
    userDataFuture = fetchUserDetails();
  }

  Future<void> fetchUserDetails() async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('farmers')
        .where('userId', isEqualTo: widget.item.userId)
        .get();

    setState(() {
      userData = querySnapshot.docs[0].data() as Map<String, dynamic>;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('වැඩිපුර විස්තර'),
        backgroundColor: Color.fromARGB(255, 1, 130, 65),
      ),
      body: FutureBuilder(
        future: userDataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            return buildItemDetails();
          }
        },
      ),
    );
  }

  Widget buildItemDetails() {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 200,
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(30),
              bottomLeft: Radius.circular(30),
            ),
            child: Image.network(
              widget.item.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 28, right: 28, top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 189, 0),
                    child: Text(
                      '${widget.item.type}',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff000000),
                      ),
                    ),
                  ),
                  Icon(Icons.shopping_cart, size: 28),
                ],
              ),
              SizedBox(height: 20),
              Text(
                'මුළු අස්වැන්න: ${widget.item.amount.toStringAsFixed(2)} Kg',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 10),
              Text('මිල (1kg): රු.${widget.item.price.toStringAsFixed(2)}',
                  textAlign: TextAlign.left, style: TextStyle(fontSize: 18)),
              SizedBox(height: 10),
              Text('${widget.item.description}',
                  textAlign: TextAlign.left, style: TextStyle(fontSize: 18)),
              SizedBox(height: 16),
              Divider(
                color: Colors.grey,
                thickness: 1,
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Container(
                    height: 80,
                    width: 80,
                    margin: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: ClipOval(
                      child: Image.network(
                        userData['profileImageURL'] ?? '',
                        width: 150,
                        height: 150,
                        scale: 1.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${userData['farmerName']}',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          )),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.location_pin,
                              size: 36, color: Color.fromARGB(255, 23, 124, 0)),
                          Text('${userData['address']}',
                              style: TextStyle(
                                fontSize: 15,
                              )),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 30),
        Center(
          child: Column(
            children: [
              const SizedBox(height: 14.0),
              SizedBox(
                width: 150.0,
                height: 50.0,
                child: ElevatedButton(
                  onPressed: ()  async {
                   await FlutterPhoneDirectCaller.callNumber(userData['contact']);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xAF018241),
                    minimumSize: Size(95, 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.call_rounded),
                      SizedBox(width: 8),
                      const Text(
                        'අමතන්න',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 45.0),
            ],
          ),
        ),
      ],
    );
  }
}
