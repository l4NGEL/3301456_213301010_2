import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PharmacyScreen extends StatefulWidget {
  @override
  _PharmacyScreenState createState() => _PharmacyScreenState();
}

class _PharmacyScreenState extends State<PharmacyScreen> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final CollectionReference _pharmacyCollection =
  FirebaseFirestore.instance.collection('pharmacy');

  TextEditingController _nameController = TextEditingController();
  TextEditingController _quantityController = TextEditingController();

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
          "Eczane Deposu",
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Ürün Adı',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  controller: _quantityController,
                  decoration: InputDecoration(
                    labelText: 'Miktar',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    child: Text('Ekle'),
                    style: ElevatedButton.styleFrom(primary: Colors.deepOrange),
                    onPressed: () {
                      _addProduct();
                    },
                  ),
                  ElevatedButton(
                    child: Text('Sil'),
                    style: ElevatedButton.styleFrom(primary: Colors.deepOrange),
                    onPressed: () {
                      _deleteProduct();
                    },
                  ),
                  ElevatedButton(
                    child: Text('Azalt'),
                    style: ElevatedButton.styleFrom(primary: Colors.deepOrange),
                    onPressed: () {
                      _decreaseQuantity();
                    },
                  ),
                  ElevatedButton(
                    child: Text('Artır'),
                    style: ElevatedButton.styleFrom(primary: Colors.deepOrange),
                    onPressed: () {
                      _increaseQuantity();
                    },
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                'Mevcut İlaçlar',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              StreamBuilder<QuerySnapshot>(
                stream: _pharmacyCollection.snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text('Hata: ${snapshot.error}');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }

                  if (snapshot.hasData) {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        var document = snapshot.data!.docs[index];
                        String productName = document['name'];
                        int productQuantity = document['quantity'];

                        return ListTile(
                          title: Text(productName),
                          subtitle: Text('Miktar: $productQuantity'),
                        );
                      },
                    );
                  }

                  return Container();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _addProduct() {
    String name = _nameController.text;
    int quantity = int.parse(_quantityController.text);

    _pharmacyCollection
        .where('name', isEqualTo: name)
        .get()
        .then((snapshot) {
      if (snapshot.docs.isEmpty) {
        // Ürün mevcut değil, yeni ürün oluşturulacak
        _pharmacyCollection
            .add({
          'name': name,
          'quantity': quantity,
        })
            .then((value) {
          print('Ürün eklendi: $name');
          _nameController.clear();
          _quantityController.clear();
        })
            .catchError((error) {
          print('Hata: $error');
        });
      } else {
        // Ürün mevcut, miktar güncellenecek
        int currentQuantity = snapshot.docs[0]['quantity'];
        int updatedQuantity = currentQuantity + quantity;

        snapshot.docs[0].reference.update({'quantity': updatedQuantity})
            .then((value) {
          print('Miktar güncellendi: $name');
          _nameController.clear();
          _quantityController.clear();
        })
            .catchError((error) {
          print('Hata: $error');
        });
      }
    })
        .catchError((error) {
      print('Hata: $error');
    });
  }

  void _deleteProduct() {
    String name = _nameController.text;

    _pharmacyCollection
        .where('name', isEqualTo: name)
        .get()
        .then((snapshot) {
      snapshot.docs.forEach((doc) {
        doc.reference.delete();
        print('Ürün silindi: $name');
      });
      _nameController.clear();
      _quantityController.clear();
    })
        .catchError((error) {
      print('Hata: $error');
    });
  }

  void _decreaseQuantity() {
    String name = _nameController.text;
    int decreaseAmount = int.parse(_quantityController.text);

    _pharmacyCollection
        .where('name', isEqualTo: name)
        .get()
        .then((snapshot) {
      snapshot.docs.forEach((doc) {
        int currentQuantity = doc['quantity'];
        int updatedQuantity = currentQuantity - decreaseAmount;

        if (updatedQuantity >= 0) {
          doc.reference.update({'quantity': updatedQuantity});
          print('Miktar azaltıldı: $name');
        } else {
          print('Hata: Yeterli stok yok');
        }
      });
      _nameController.clear();
      _quantityController.clear();
    })
        .catchError((error) {
      print('Hata: $error');
    });
  }

  void _increaseQuantity() {
    String name = _nameController.text;

    _pharmacyCollection
        .where('name', isEqualTo: name)
        .get()
        .then((snapshot) {
      snapshot.docs.forEach((doc) {
        int currentQuantity = doc['quantity'];
        doc.reference.update({'quantity': currentQuantity + 1});
        print('Miktar artırıldı: $name');
      });
      _nameController.clear();
      _quantityController.clear();
    })
        .catchError((error) {
      print('Hata: $error');
    });
  }
}
