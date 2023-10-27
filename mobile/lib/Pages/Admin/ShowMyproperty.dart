import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'AddProperty.dart';
import 'UpdateProperty.dart';
import 'package:provider/provider.dart';
import 'package:mobile/Pages/Common/login_page.dart';

class MyProperty extends StatefulWidget {
  @override
  _MyPropertyState createState() => _MyPropertyState();
}

class _MyPropertyState extends State<MyProperty> {
  double fem = 1.0; // Adjust this value as needed

  FirebaseFirestore firestore =
      FirebaseFirestore.instance; // Initialize Firestore

  // Define a list to store property data
  List<Map<String, dynamic>> properties = [];

  int selectedPropertyIndex = -1;
  String loginEmail = '';

  @override
  void initState() {
    super.initState();
    loginEmail = Provider.of<LoginEmailProvider>(context, listen: false).email;
    Firebase.initializeApp();
    fetchDataFromFirestore();
    // Fetch data from Firestore when the widget is initialized
  }

  Future fetchDataFromFirestore() async {
    try {
      // Retrieve property data from Firestore
      QuerySnapshot querySnapshot = await firestore
          .collection('properties')
          .where('email', isEqualTo: loginEmail)
          .get();
      final List<QueryDocumentSnapshot> propertyDocuments = querySnapshot.docs;

      List<Map<String, dynamic>> propertiesData = [];

      for (var propertyDoc in propertyDocuments) {
        Map<String, dynamic>? propertyData =
            propertyDoc.data() as Map<String, dynamic>?;

        if (propertyData != null) {
          // Add the document ID to the property data
          propertyData['documentId'] = propertyDoc.id;
          propertiesData.add(propertyData);
        }
      }

      setState(() {
        properties = propertiesData;
      });
    } catch (e) {
      print("Error fetching data from Firestore: $e");
    }
  }

  void deletePropertyCallback(String documentId) {
    deleteProperty(documentId);
  }

  void deleteProperty(String documentId) async {
    try {
      await firestore.collection('properties').doc(documentId).delete();
      fetchDataFromFirestore(); // Refresh the data after deletion
      print("Property deleted successfully");
    } catch (e) {
      print("Error deleting property: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    print('Login Email: $loginEmail');
    return Scaffold(
      appBar: AppBar(
        title: Text("මගේ දේපල"),
        backgroundColor: Color.fromARGB(255, 1, 130, 65),
      ),
      body: Column(
        children: <Widget>[
          // Static image container placed outside the scrolling area
          Container(
            padding:
                EdgeInsets.fromLTRB(15 * fem, 9 * fem, 16 * fem, 144 * fem),
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                    "assets/1.png"), // Replace with your image asset path
              ),
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                await fetchDataFromFirestore();
              },
              child: ListView.builder(
                itemCount: properties.length + 1,
                itemBuilder: (context, index) {
                  if (index == properties.length) {
                    // This is the "Add Property" button
                    return Container(
                      margin: EdgeInsets.fromLTRB(
                        84 * fem,
                        8 * fem,
                        83 * fem,
                        8 * fem,
                      ),
                      width: double.infinity,
                      height: 55 * fem,
                      decoration: BoxDecoration(
                        color: Color(0xaf018241),
                        borderRadius: BorderRadius.circular(30 * fem),
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddProperty(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xaf018241),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30 * fem),
                          ),
                        ),
                        child: Text(
                          'නව දේපල',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 26 * fem,
                            fontWeight: FontWeight.w600,
                            color: Color(0xffffffff),
                          ),
                        ),
                      ),
                    );
                  }
                  final property = properties[index];
                  return PropertyContainer(
                    property: property,
                    documentId: property['documentId'],
                    fem: fem,
                    isSelected: selectedPropertyIndex == index,
                    onPressed: () {
                      setState(() {
                        if (selectedPropertyIndex == index) {
                          selectedPropertyIndex = -1;
                        } else {
                          selectedPropertyIndex = index;
                        }
                      });
                    },
                    onDelete: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return DataDeleteDialog(
                            onConfirmDelete: () {
                              deletePropertyCallback(property['documentId']);
                              Navigator.of(context).pop(); // Close the dialog
                            },
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PropertyContainer extends StatelessWidget {
  final Map<String, dynamic> property;
  final String documentId; // Document ID
  final double fem;
  final bool isSelected;
  final VoidCallback onPressed;
  final VoidCallback onDelete;

  PropertyContainer({
    required this.property,
    required this.documentId,
    required this.fem,
    required this.isSelected,
    required this.onPressed,
    required this.onDelete, // Add this parameter
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        height: isSelected ? 160 : 92,
        margin: EdgeInsets.all(8),
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side:
                BorderSide(width: 3, color: Color.fromARGB(255, 166, 240, 137)),
            borderRadius: BorderRadius.circular(15 * fem),
          ),
          shadows: [
            BoxShadow(
              color: Color(0x3F000000),
              blurRadius: 5,
              offset: Offset(0, 4),
              spreadRadius: 0,
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              left: 18,
              top: 12,
              child: Text(
                ' ${property['propertyname']}',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontFamily: 'Iskoola Pota',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),
            ),
            Positioned(
              left: 18,
              top: 37,
              child: Text(
                'Acres: ${property['area']}',
                style: TextStyle(
                  color: Color(0xFF797373),
                  fontSize: 15,
                  fontFamily: 'Iskoola Pota',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),
            ),
            Positioned(
              left: 18,
              top: 60,
              child: Text(
                'Water Source: ${property['watercomingmethod']}',
                style: TextStyle(
                  color: Color(0xFF797373),
                  fontSize: 15,
                  fontFamily: 'Iskoola Pota',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),
            ),
            Positioned(
              left: 197,
              top: 37,
              child: Text(
                'Owner: ${property['ownername']}',
                style: TextStyle(
                  color: Color(0xFF797373),
                  fontSize: 15,
                  fontFamily: 'Iskoola Pota',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),
            ),
            Positioned(
              left: 197,
              top: 60,
              child: Text(
                'District: ${property['district']}',
                style: TextStyle(
                  color: Color(0xFF797373),
                  fontSize: 15,
                  fontFamily: 'Iskoola Pota',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),
            ),
            // Display the document ID within the card
            if (isSelected)
              Positioned(
                right: 23,
                top: 100, // Adjust the position as needed
                child: Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Handle update button click
                        // Pass the document ID to the UpdateProperty page
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                UpdateProperty(documentId: documentId),
                          ),
                        );
                      },
                      child: Text('යාවත්කාලීන'),
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xffaee49b),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20 * fem),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: onDelete,
                      child: Text('Delete'),
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xfffb758d),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20 * fem),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class DataDeleteDialog extends StatelessWidget {
  final VoidCallback onConfirmDelete;

  DataDeleteDialog({required this.onConfirmDelete});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 280,
        height: 320,
        child: Stack(
          children: [
            Positioned(
              left: 0,
              top: 0,
              child: Container(
                width: 280,
                height: 275,
                decoration: ShapeDecoration(
                  color: Color(0xFFF5F5F5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  shadows: [
                    BoxShadow(
                      color: Color(0x3F000000),
                      blurRadius: 15,
                      offset: Offset(0, 4),
                      spreadRadius: 5,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 92,
              top: 0,
              child: Container(
                width: 100,
                height: 90,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/Error.png'),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 18,
              top: 95, // Adjusted the top position
              child: SizedBox(
                width: 243,
                height: 130,
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: '\n ',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      TextSpan(
                        text: 'අවවාදයයි\n',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      TextSpan(
                        text: '\n',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      TextSpan(
                        text: 'ඔබට තොරතුරු මකා දැමීමට අවශ්‍යද..?\n',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextSpan(
                        text: '\n',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Positioned(
              left: 20,
              right: 20,
              bottom: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: onConfirmDelete,
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                      minimumSize: Size(95, 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: Text(
                      'ඔව්',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xAF018241),
                      minimumSize: Size(95, 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: Text(
                      'නැත',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}



