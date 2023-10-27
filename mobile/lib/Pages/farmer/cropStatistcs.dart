// import 'package:flutter/material.dart';

// void main() {
//   runApp(MaterialApp(
//     home: CropStats(),
//   ));
// }

// class CropStats extends StatefulWidget {
//   const CropStats({super.key});

//   @override
//   State<CropStats> createState() => _CropStatsState();
// }

// class _CropStatsState extends State<CropStats> {
//   String selectedRegion = 'Sri Lanka';
//   String? selectedProvince;
//   String? selectedDistrict;
//   String? selectedDivisionalSecretary;
//   String? selectedCropType;
//   String totalLands = '1000 acres';
//   String totalHarvest = '1500 tons';
//   String lastSeasonLands = '800 acres';
//   String lastSeasonHarvest = '1200 tons';

//   List<String> provinces = ["Province 1", "Province 2", "Province 3", "Province 4"];
//   List<String> districts = ["District 1", "District 2", "District 3", "District 4"];
//   List<String> divisionalSecretaries = ["Secretary 1", "Secretary 2", "Secretary 3"];
//   List<String> cropTypes = ["Crop Type 1", "Crop Type 2", "Crop Type 3"];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Crop Statistics"),
//         backgroundColor: const Color.fromARGB(255, 1, 130, 65),
//       ),
//       body: Column(
//         children: [
//           Container(
//             child: Image.asset(
//               'assets/cropStat.jpeg',
//               height: 300,
//               width: 375,
//               scale: 1.0,
//             ),
//           ),
//           Expanded(
//             child: SingleChildScrollView(
//               padding: const EdgeInsets.only(left: 20, right: 20, bottom: 12, top: 12),
//               child: Column(
//                 children: [
//                   SizedBox(height: 16),
//                   buildDropdownFieldForCropType(),

//                   SizedBox(height: 16),
//                   buildRegionRadioButtons(),

//                   if (selectedRegion == 'Province' ||
//                       selectedRegion == 'District' ||
//                       selectedRegion == 'Divisional Secretary')
//                     buildDropdownFieldForProvincesDistrictsSecretary(),

//                   Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: ElevatedButton(
//                       onPressed: () {
//                         // Show the details in a pop-up box
//                         showDetailsPopup(context);
//                       },
//                       style: ButtonStyle(
//                         backgroundColor: MaterialStateProperty.all<Color>(
//                           const Color.fromARGB(255, 42, 175, 46),
//                         ),
//                         minimumSize: MaterialStateProperty.all<Size>(Size(170, 50)),
//                         shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                           RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(15.0),
//                           ),
//                         ),
//                       ),
//                       child: Text('Show'),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget buildDropdownFieldForCropType() {
//     return buildDropdownField(
//       cropTypes,
//       'Select a Crop Type',
//       selectedCropType,
//       (newValue) {
//         setState(() {
//           selectedCropType = newValue;
//         });
//       },
//     );
//   }

//   Widget buildRegionRadioButtons() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Select a Region',
//           style: TextStyle(
//             fontSize: 16.0,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         SizedBox(height: 8),
//         Column(
//           children: [
//             RadioListTile(
//               title: Text('Sri Lanka'),
//               value: 'Sri Lanka',
//               groupValue: selectedRegion,
//               onChanged: (value) {
//                 setState(() {
//                   selectedRegion = value.toString();
//                   selectedProvince = null;
//                   selectedDistrict = null;
//                   selectedDivisionalSecretary = null;
//                 });
//               },
//             ),
//             RadioListTile(
//               title: Text('Province'),
//               value: 'Province',
//               groupValue: selectedRegion,
//               onChanged: (value) {
//                 setState(() {
//                   selectedRegion = value.toString();
//                   selectedProvince = null;
//                   selectedDistrict = null;
//                   selectedDivisionalSecretary = null;
//                 });
//               },
//             ),
//             RadioListTile(
//               title: Text('District'),
//               value: 'District',
//               groupValue: selectedRegion,
//               onChanged: (value) {
//                 setState(() {
//                   selectedRegion = value.toString();
//                   selectedProvince = null;
//                   selectedDistrict = null;
//                   selectedDivisionalSecretary = null;
//                 });
//               },
//             ),
//             RadioListTile(
//               title: Text('Divisional Secretary'),
//               value: 'Divisional Secretary',
//               groupValue: selectedRegion,
//               onChanged: (value) {
//                 setState(() {
//                   selectedRegion = value.toString();
//                   selectedProvince = null;
//                   selectedDistrict = null;
//                   selectedDivisionalSecretary = null;
//                 });
//               },
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget buildDropdownField(List<String> items, String label, String? selectedValue, void Function(String?) onChanged) {
//     return Padding(
//       padding: const EdgeInsets.only(top: 16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             label,
//             style: TextStyle(
//               fontSize: 16.0,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10.0),
//                 color: Colors.white,
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.grey.withOpacity(1.0),
//                     spreadRadius: 2,
//                     blurRadius: 5,
//                     offset: Offset(0, 2),
//                   ),
//                 ],
//               ),
//               child: DropdownButtonFormField<String>(
//                 value: selectedValue,
//                 onChanged: onChanged,
//                 items: items.map((item) {
//                   return DropdownMenuItem(
//                     value: item,
//                     child: Text(item),
//                   );
//                 }).toList(),
//                 decoration: InputDecoration(
//                   contentPadding: const EdgeInsets.all(16.0),
//                   border: InputBorder.none,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget buildDropdownFieldForProvincesDistrictsSecretary() {
//     if (selectedRegion == 'Province') {
//       return buildDropdownField(
//         provinces,
//         'Select a Province',
//         selectedProvince,
//         (newValue) {
//           setState(() {
//             selectedProvince = newValue;
//           });
//         },
//       );
//     } else if (selectedRegion == 'District') {
//       return buildDropdownField(
//         districts,
//         'Select a District',
//         selectedDistrict,
//         (newValue) {
//           setState(() {
//             selectedDistrict = newValue;
//           });
//         },
//       );
//     } else if (selectedRegion == 'Divisional Secretary') {
//       return buildDropdownField(
//         divisionalSecretaries,
//         'Select a Divisional Secretary',
//         selectedDivisionalSecretary,
//         (newValue) {
//           setState(() {
//             selectedDivisionalSecretary = newValue;
//           });
//         },
//       );
//     } else {
//       return Container();
//     }
//   }




// void showDetailsPopup(BuildContext context) {
//   showDialog(
//     context: context,
//     builder: (context) {
//       return Dialog(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(16.0), // Adjust the border radius
//         ),
//         backgroundColor: Colors.white, // Background color for the dialog
//         child: Container(
//           padding: const EdgeInsets.all(16.0),
//           decoration: BoxDecoration(
//             border: Border.all(color: const Color.fromARGB(255, 20, 91, 23), width: 4.0),
//             borderRadius: BorderRadius.circular(16.0),
//             color: Color.fromARGB(255, 244, 245, 244), // Green border color
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.grey.withOpacity(0.5),
//                 spreadRadius: 5,
//                 blurRadius: 7,
//                 offset: Offset(0, 3),
//               ),
//             ],
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               buildDetailsBox("Total Lands:", totalLands),
//               buildDetailsBox("Total Harvest:", totalHarvest),
//               buildDetailsBox("Last Season Lands:", lastSeasonLands),
//               buildDetailsBox("Last Season Harvest:", lastSeasonHarvest),
//               SizedBox(height: 16),
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 child: Text('Close'),
//               ),
//             ],
//           ),
//         ),
//       );
//     },
//   );
// }

// Widget buildDetailsBox(String label, String value) {
//   return Container(
//     margin: EdgeInsets.only(bottom: 16),
//     padding: const EdgeInsets.all(16.0),
//     decoration: BoxDecoration(
//       borderRadius: BorderRadius.circular(16.0),
//       color: Colors.white,
//       boxShadow: [
//         BoxShadow(
//           color: Colors.grey.withOpacity(0.5),
//           spreadRadius: 3,
//           blurRadius: 5,
//           offset: Offset(0, 3),
//         ),
//       ],
//     ),
//     child: Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Text(
//           label,
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             color: const Color.fromARGB(255, 25, 25, 26),
//           ),
//         ),
//         Text(
//           value,
//           style: TextStyle(
//             color: const Color.fromARGB(255, 113, 114, 113),
//           ),
//         ),
//       ],
//     ),
//   );
// }
// }




import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class CropStaristic extends StatefulWidget {
  const CropStaristic({Key? key}) : super(key: key);

  @override
  State<CropStaristic> createState() => _AdminCropStaristicState();
}

class _AdminCropStaristicState extends State<CropStaristic> {
  String selectedRegion = 'Sri Lanka';
  String? selectedProvince;
  String? selectedDistrict;
  String? selectedDivisionalSecretary;
  String? selectedCropType;

  List<String> provinces = [
    "මධ්‍යම පළාත",
    "සබරගමුව පළාත",
    "නැගෙනහිර පළාත",
    "ඌව පළාත",
    "දකුණු පළාත"
  ];
  List<String> districts = [
    "මොණරාගල",
    "බදුල්ල",
  ];
  List<String> divisionalSecretaries = [
    "වැල්ලවාය",
    "බුත්තල",
    "තණමල්විල",
  ];
  List<String> cropTypes = [
    "වී",
    "වට්ටක්කා",
    "මිරිස්",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("බෝග සංඛ්‍යා ලේකන"),
        backgroundColor: const Color.fromARGB(255, 1, 130, 65),
      ),
      body: Column(
        children: [
          Image.asset(
            "assets/cropStat.jpeg",
            height: 300,
            width: 375,
            scale: 1.0,
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
                bottom: 12,
                top: 12,
              ),
              child: Column(
                children: [
                  buildDropdownFieldForCropType(),
                  buildRegionRadioButtons(),
                  if (selectedRegion == 'Province' ||
                      selectedRegion == 'District' ||
                      selectedRegion == 'Divisional Secretary')
                    buildDropdownFieldForProvincesDistrictsSecretary(),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ElevatedButton(
                      onPressed: () {
                        fetchDataFromFirestore();
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          const Color.fromARGB(255, 1, 130, 65),
                        ),
                        minimumSize: MaterialStateProperty.all<Size>(Size(170, 50)),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                      ),
                      child: Text('පෙන්වන්න'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDropdownFieldForCropType() {
    return buildDropdownField(
      cropTypes,
      'බෝග වර්ගය',
      selectedCropType,
      (newValue) {
        setState(() {
          selectedCropType = newValue;
        });
      },
    );
  }

  Widget buildRegionRadioButtons() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'කලාපය තෝරන්න',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        Column(
          children: [
            RadioListTile(
              title: Text('සියල්ලම'),
              value: 'Sri Lanka',
              groupValue: selectedRegion,
              onChanged: (value) {
                setState(() {
                  selectedRegion = value.toString();
                  selectedProvince = null;
                  selectedDistrict = null;
                  selectedDivisionalSecretary = null;
                });
              },
            ),
            RadioListTile(
              title: Text('පළාත්'),
              value: 'Province',
              groupValue: selectedRegion,
              onChanged: (value) {
                setState(() {
                  selectedRegion = value.toString();
                  selectedProvince = null;
                  selectedDistrict = null;
                  selectedDivisionalSecretary = null;
                });
              },
            ),
            RadioListTile(
              title: Text('දිස්ත්‍රික්කය'),
              value: 'District',
              groupValue: selectedRegion,
              onChanged: (value) {
                setState(() {
                  selectedRegion = value.toString();
                  selectedProvince = null;
                  selectedDistrict = null;
                  selectedDivisionalSecretary = null;
                });
              },
            ),
            RadioListTile(
              title: Text('ප්‍රා.ලේ.කො'),
              value: 'Divisional Secretary',
              groupValue: selectedRegion,
              onChanged: (value) {
                setState(() {
                  selectedRegion = value.toString();
                  selectedProvince = null;
                  selectedDistrict = null;
                  selectedDivisionalSecretary = null;
                });
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget buildDropdownFieldForProvincesDistrictsSecretary() {
    List<String> items = [];
    String title = '';

    if (selectedRegion == 'Province') {
      items = provinces;
      title = 'පළාත';
    } else if (selectedRegion == 'District') {
      items = districts;
      title = 'දිසා';
    } else if (selectedRegion == 'Divisional Secretary') {
      items = divisionalSecretaries;
      title = 'ප්‍රා. ලේකන';
    }

    return Column(
      children: [
        buildDropdownField(
          items,
          'තෝරන්න',
          selectedRegion == 'Province' ? selectedProvince : (selectedRegion == 'District' ? selectedDistrict : selectedDivisionalSecretary),
          (newValue) {
            setState(() {
              if (selectedRegion == 'Province') {
                selectedProvince = newValue;
              } else if (selectedRegion == 'District') {
                selectedDistrict = newValue;
              } else if (selectedRegion == 'Divisional Secretary') {
                selectedDivisionalSecretary = newValue;
              }
            });
          },
        ),
      ],
    );
  }

  Widget buildDropdownField(
    List<String> items,
    String hintText,
    String? selectedValue,
    Function(String?) onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          hintText,
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        DropdownButton<String>(
          isExpanded: true,
          hint: Text('තෝරන්න'),
          value: selectedValue,
          onChanged: onChanged,
          items: items.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ],
    );
  }

Future<void> fetchDataFromFirestore() async {
  final firestore = FirebaseFirestore.instance;
  final selectedType = selectedCropType; // Use a different variable name

  if (selectedType != null) {
    final query = firestore.collection('crops').where('cropType', isEqualTo: selectedType);
    final querySnapshot = await query.get();

    double totalArea = 0.0;
    double totalHarvest = 0.0;

    for (final doc in querySnapshot.docs) {
      final data = doc.data() as Map<String, dynamic>;
      final area = double.tryParse(data['area'] ?? '0') ?? 0.0;
      final harvest = double.tryParse(data['expectedHarvest'] ?? '0') ?? 0.0;

      totalArea += area;
      totalHarvest += harvest;
    }

    final formattedTotalArea = totalArea.toStringAsFixed(2);
    final formattedTotalHarvest = totalHarvest.toStringAsFixed(2);

    showDetailsPopup(context, formattedTotalArea, formattedTotalHarvest);
  } else {
    // Handle the case where no cropType is selected
  }
}


  void showDetailsPopup(BuildContext context, String totalArea, String totalHarvest) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          backgroundColor: Colors.white,
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                buildDetailsBox("වගාකර ඇති සම්පූර්ණ භූමි ප්‍රමාණය : \n", totalArea),
                buildDetailsBox("\n",("")),
                buildDetailsBox("අපේක්ෂිත සම්පූර්ණ අස්වැන්න : \n", totalHarvest),
                SizedBox(height: 16),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Close'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildDetailsBox(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14.0,
          ),
        ),
      ],
    );
  }
}









