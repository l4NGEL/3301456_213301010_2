import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class IlacSorguPage extends StatefulWidget {
  @override
  _IlacSorguPageState createState() => _IlacSorguPageState();
}

class _IlacSorguPageState extends State<IlacSorguPage> {
  final CollectionReference codesCollection =
  FirebaseFirestore.instance.collection('codes');

  final TextEditingController codeController = TextEditingController();
  String medicine = '';

  Future<void> searchMedicine(String code) async {
    QuerySnapshot querySnapshot = await codesCollection
        .where('code', isEqualTo: code)
        .limit(1)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      setState(() {
        medicine = querySnapshot.docs[0].get('medicine');
      });
    } else {
      setState(() {
        medicine = 'İlaç bulunamadı.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back,color: Colors.black,),
          onPressed: () {
            Navigator.pop(context); // Geri düğmesi işlevselliği
          },
        ),
        title: Text(
          "Kod Sorgulama",
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Lütfen Reçete Kodunuzu giriniz',
              style: TextStyle(
                color: Colors.deepOrange,
                  fontSize: 36,
                  fontWeight: FontWeight.w300),
            ),
            SizedBox(height: 8),
            TextField(
              decoration: InputDecoration(
                labelText: 'Kod Girin',
              ),
              controller: codeController,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String code = codeController.text;
                searchMedicine(code);
              },
              child: Text('Sorgula'),
              style: ElevatedButton.styleFrom(primary: Colors.deepOrange),
            ),
            SizedBox(height: 20),
            Text(
              'İlaç: $medicine',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
