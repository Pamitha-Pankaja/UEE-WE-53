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
        title: Text("My Properties"),
        backgroundColor: const Color.fromARGB(255, 42, 175, 46),
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
                          'Add Property',
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
                      deletePropertyCallback(property['documentId']);
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
                      child: Text('Update'),
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xffaee49b),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20 * fem),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        onDelete();
                      },
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
