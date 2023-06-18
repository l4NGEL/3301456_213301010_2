import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CardInfoPage extends StatefulWidget {
  @override
  _CardInfoPageState createState() => _CardInfoPageState();
}

class _CardInfoPageState extends State<CardInfoPage> {
  TextEditingController _kartNumarasiController = TextEditingController();
  TextEditingController _adSoyadController = TextEditingController();
  TextEditingController _cvvController = TextEditingController();
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<Map<String, String>> _cardList = [];

  void _kaydet() async {
    final cardNumber = _kartNumarasiController.text;
    final name = _adSoyadController.text;
    final cvv = _cvvController.text;

    try {
      await _firestore.collection('payment_info').add({
        'cardNumber': cardNumber,
        'name': name,
        'cvv': cvv,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Kart bilgileri kaydedildi."),
        ),
      );

      _kartNumarasiController.clear();
      _adSoyadController.clear();
      _cvvController.clear();

      setState(() {
        _cardList.add({
          'cardNumber': cardNumber,
          'name': name,
          'cvv': cvv,
        });
      });
    } catch (e) {
      print('Error saving payment information: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Kart bilgileri kaydedilemedi. Lütfen tekrar deneyiniz."),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF800000),
        title: Text("Kart Bilgileri"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _kartNumarasiController,
              decoration: InputDecoration(hintText: "Kart Numarası"),
            ),
            TextField(
              controller: _adSoyadController,
              decoration: InputDecoration(hintText: "Ad ve Soyad"),
            ),
            TextField(
              controller: _cvvController,
              decoration: InputDecoration(hintText: "CVV"),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              child: Text("Kaydet"),
              style: ElevatedButton.styleFrom(primary: Colors.red[600]),
              onPressed: _kaydet,
            ),
            SizedBox(height: 16.0),
            Text(
              "Kaydedilen Kartlar",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Expanded(
              child: ListView.builder(
                itemCount: _cardList.length,
                itemBuilder: (context, index) {
                  final cardInfo = _cardList[index];
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    padding: EdgeInsets.all(16.0),
                    margin: EdgeInsets.only(bottom: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Kart Numarası: ${cardInfo['cardNumber']}",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8.0),
                        Text("Ad ve Soyad: ${cardInfo['name']}"),
                        SizedBox(height: 8.0),
                        Text("CVV: ${cardInfo['cvv']}"),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
