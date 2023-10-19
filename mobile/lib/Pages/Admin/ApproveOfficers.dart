import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: ApproveOfficers(),
  ));
}

class ApproveOfficers extends StatefulWidget {
  const ApproveOfficers({super.key});

  @override
  State<ApproveOfficers> createState() => _ApproveOfficersState();
}

class _ApproveOfficersState extends State<ApproveOfficers> {
  // Define a list of data with names and divisions
  List<Map<String, dynamic>> data = [
    {
      'Name': "Tharuka",
      'Division': "Wellawaya",
      'email': "Email@gmail.com",
      'district': "Monaragala",
      'province': "Uva",
    },
    {
      'Name': "Pamitha",
      'Division': "Galle",
      'email': "Email@gmail.com",
      'district': "Monaragala",
      'province': "Uva",
    },
    {
      'Name': "Nipun",
      'Division': "Hanwella",
      'email': "Email@gmail.com",
      'district': "Monaragala",
      'province': "Uva",
    },
    {
      'Name': "Tharuka",
      'Division': "Wellawaya",
      'email': "Email@gmail.com",
      'district': "Monaragala",
      'province': "Uva",
    },
    {
      'Name': "Pamitha",
      'Division': "Galle",
      'email': "Email@gmail.com",
      'district': "Monaragala",
      'province': "Uva",
    },
    {
      'Name': "Nipun",
      'Division': "Hanwella",
      'email': "Email@gmail.com",
      'district': "Monaragala",
      'province': "Uva",
    },
    {
      'Name': "Tharuka",
      'Division': "Wellawaya",
      'email': "Email@gmail.com",
      'district': "Monaragala",
      'province': "Uva",
    },
    {
      'Name': "Pamitha",
      'Division': "Galle",
      'email': "Email@gmail.com",
      'district': "Monaragala",
      'province': "Uva",
    },
    {
      'Name': "Nipun",
      'Division': "Hanwella",
      'email': "Email@gmail.com",
      'district': "Monaragala",
      'province': "Uva",
    },
    
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("කෘෂිකර්ම නිලධාරීන්"),
        backgroundColor: Color.fromARGB(255, 42, 175, 46),
      ),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: 600),
          child: DataTable(
            columns: [
              DataColumn(label: Text('Name')),
              DataColumn(label: Text('Division')),
              DataColumn(label: Text('Approve')),
            ],
            rows: data
                .map(
                  (item) => DataRow(
                    cells: [
                      DataCell(Text(item['Name'] ?? '')),
                      DataCell(Text(item['Division'] ?? '')),
                      DataCell(ElevatedButton(
                        onPressed: () {
                          // Add your approval logic here
                        },
                        child: Text('Approve'),
                      )),
                    ],
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
