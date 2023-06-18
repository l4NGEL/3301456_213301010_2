import 'dart:math';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RandomCodePage extends StatelessWidget {
  final CollectionReference codesCollection =
  FirebaseFirestore.instance.collection('codes');

  final TextEditingController codeController = TextEditingController();
  final TextEditingController medicineController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  void addCode(String code, String medicine) {
    codesCollection.add({
      'code': code,
      'medicine': medicine,
      'name': nameController.text,
    });
  }

  String generateRandomCode() {
    Random random = Random();
    int code = random.nextInt(900000) + 100000;
    return code.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context); // Geri düğmesi işlevselliği
          },
        ),
        title: Text(
          "Reçete kodu oluştur",
          style: TextStyle(
            color: Colors.black,
            fontSize: 28,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'Random Code',
                ),
                enabled: false,
                controller: codeController,
              ),
              SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Hasta isim soyisim',
                ),
                controller: nameController,
              ),
              SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Medicine',
                ),
                controller: medicineController,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  String code = generateRandomCode();
                  String medicine = medicineController.text;
                  String isimSoyisim = nameController.text;
                  addCode(code, medicine);
                  codeController.text = code;
                  medicineController.text = '';
                  nameController.text = '';
                },
                child: Text('Kaydet'),
                style: ElevatedButton.styleFrom(primary: Colors.deepOrange),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
