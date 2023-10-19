import 'package:flutter/material.dart';

class CropCard extends StatelessWidget {
  final String cropType;
  final String agriculturalProperty;
  final String waterSource;
  final String area;
  final String expectedHarvest;
  final VoidCallback onUpdate;
  final VoidCallback onDelete;

  CropCard({
    required this.cropType,
    required this.agriculturalProperty,
    required this.waterSource,
    required this.area,
    required this.expectedHarvest,
    required this.onUpdate,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromARGB(255, 20, 91, 23), width: 2.0),
        borderRadius: BorderRadius.circular(8.0),
      ),
      margin: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'cropType: $cropType',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Text('Property: $agriculturalProperty'),
                ),
                Text('Water Source: $waterSource'),
                Text('Acres: $area'),
                Text('Expected Harvest: $expectedHarvest'),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 5.0,right: 5.0),
                child: ElevatedButton(
                  onPressed: onUpdate,
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      Color.fromARGB(255, 57, 144, 60),
                    ),
                    minimumSize: MaterialStateProperty.all<Size>(Size(75, 30)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                  ),
                  child: Text('Update'),
                ),
              ),
              SizedBox(width: 8.0),
              Padding(
                padding: const EdgeInsets.only(bottom: 5.0,right: 5.0),
                child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Row(
                          children: [
                            Icon(
                              Icons.warning,
                              color: Colors.red,
                              size: 28,
                            ),
                            SizedBox(width: 8),
                            Text("Delete Crop"),
                          ],
                        ),
                        content: Text("Do you want to delete this crop?"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              "No",
                              style: TextStyle(
                                color: Color.fromARGB(255, 44, 138, 7),
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              onDelete();
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              "Yes",
                              style: TextStyle(
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      Colors.red,
                    ),
                    minimumSize: MaterialStateProperty.all<Size>(Size(75, 30)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                  ),
                  child: Text('Delete'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

