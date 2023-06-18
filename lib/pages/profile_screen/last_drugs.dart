import 'package:flutter/material.dart';

class LastDrugs extends StatefulWidget {
  @override
  _LastDrugsState createState() => _LastDrugsState();
}

class _LastDrugsState extends State<LastDrugs> {
  List<Map<String, dynamic>> _lastDrugs = [
    {'name': 'KLAVUNAT', 'date': '02.04.2023'},
    {'name': 'ARVELES', 'date': '03.04.2023'},
    {'name': 'CLİNDOXLY JEL KREM', 'date': '04.04.2023'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF800000),
        title: Text('Son Alınan İlaçlar'),
      ),
      body: ListView.builder(
        itemCount: _lastDrugs.length,
        itemBuilder: (context, index) {
          final drug = _lastDrugs[index];
          return ListTile(
            leading: Icon(Icons.add_circle),
            title: Text('${drug['name']} - ${drug['date']}'),
            onTap: () {
              // İlaç detayları sayfasına yönlendir
            },
          );
        },
      ),
    );
  }
}
