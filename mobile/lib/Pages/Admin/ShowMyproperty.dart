import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: MyProperty(),
  ));
}

class MyProperty extends StatefulWidget {
  @override
  _MyPropertyState createState() => _MyPropertyState();
}

class _MyPropertyState extends State<MyProperty> {
  double fem = 1.0; // Adjust this value as needed

  // Define a list of property data
  List<Map<String, dynamic>> properties = [
    // Sample property data, you can add more entries
    {
      'Property Name': 'HomeGarden',
      'Acres': 10,
      'Water Source': 'Tank',
      'Owner': 'Tharuka',
      'District': 'Monaragala',
    },
    {
      'Property Name': 'PaddyField',
      'Acres': 1,
      'Water Source': 'Tank',
      'Owner': 'Tharuka',
      'District': 'Monaragala',
    },
    // Add more property entries here...
  ];

  int selectedPropertyIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("මගේ දේපල"),
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
                    "assets/1.png"), // Replace "assets/1.png" with your image asset path
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: properties.length + 1,
              itemBuilder: (context, index) {
                if (index == properties.length) {
                  // This is the "Add Property" button
                  return Container(
                    margin: EdgeInsets.fromLTRB(
                        84 * fem, 8 * fem, 83 * fem, 8 * fem),
                    width: double.infinity,
                    height: 55 * fem,
                    decoration: BoxDecoration(
                      color: Color(0xaf018241),
                      borderRadius: BorderRadius.circular(30 * fem),
                    ),
                    child: Center(
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
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class PropertyContainer extends StatelessWidget {
  final Map<String, dynamic> property;
  final double fem;
  final bool isSelected;
  final VoidCallback onPressed;

  PropertyContainer({
    required this.property,
    required this.fem,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        height: isSelected ? 140 : 92,
        margin: EdgeInsets.all(8),
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 3, color: Color(0xFF8BF089)),
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
                'Property Name: ${property['Property Name']}',
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
                'Acres: ${property['Acres']}',
                style: TextStyle(
                  color: Color(0xFF797373),
                  fontSize: 13,
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
                'Water Source: ${property['Water Source']}',
                style: TextStyle(
                  color: Color(0xFF797373),
                  fontSize: 13,
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
                'Owner: ${property['Owner']}',
                style: TextStyle(
                  color: Color(0xFF797373),
                  fontSize: 13,
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
                'District: ${property['District']}',
                style: TextStyle(
                  color: Color(0xFF797373),
                  fontSize: 13,
                  fontFamily: 'Iskoola Pota',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),
            ),
            if (isSelected)
              Positioned(
                right: 18,
                top: 85,
                child: Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Handle update button click
                        // Add your update logic here
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
                        // Handle delete button click
                        // Add your delete logic here
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
