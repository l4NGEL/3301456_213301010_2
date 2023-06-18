import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../model/product_model.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();

  static List<Product> sepetUrunler = [];
}

class _CartPageState extends State<CartPage> {
  double _toplamFiyat = 0.0;
  TextEditingController _kartNumarasiController = TextEditingController();
  TextEditingController _adSoyadController = TextEditingController();
  TextEditingController _cvvController = TextEditingController();
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _hesaplaToplamFiyat();
  }

  void _hesaplaToplamFiyat() {
    double toplam = 0.0;
    for (var urun in CartPage.sepetUrunler) {
      toplam += urun.price;
    }
    setState(() {
      _toplamFiyat = toplam;
    });
  }

  void _urunCikar(int index) {
    setState(() {
      CartPage.sepetUrunler.removeAt(index);
      _hesaplaToplamFiyat();
    });
  }

  void _odemeYap() async {
    final cardNumber = _kartNumarasiController.text;
    final cvv = _cvvController.text;

    try {
      QuerySnapshot snapshot = await _firestore
          .collection('payment_info')
          .where('cardNumber', isEqualTo: cardNumber)
          .where('cvv', isEqualTo: cvv)
          .get();

      if (snapshot.docs.isNotEmpty) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PaymentSuccessPage()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Ödeme Bilgileri Hatalı! Lütfen tekrar deneyiniz."),
          ),
        );
      }
    } catch (e) {
      print('Error retrieving payment information: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Ödeme Bilgileri Alınamadı! Lütfen tekrar deneyiniz."),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF800000),
        title: Text("Sepet"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: CartPage.sepetUrunler.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: Key(CartPage.sepetUrunler[index].name),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: Colors.red,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.only(right: 16.0),
                        child: Icon(Icons.delete, color: Colors.white),
                      ),
                    ),
                  ),
                  onDismissed: (direction) {
                    _urunCikar(index);
                  },
                  child: ListTile(
                    title: Text(CartPage.sepetUrunler[index].name),
                    subtitle: Text(CartPage.sepetUrunler[index].category),
                    trailing: Text("${CartPage.sepetUrunler[index].price}"),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Toplam Fiyat: $_toplamFiyat",
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16.0),
                TextField(
                  controller: _kartNumarasiController,
                  decoration: InputDecoration(hintText: "Kart Numarası"),
                ),
                TextField(
                  controller: _adSoyadController,
                  decoration: InputDecoration(hintText: "Adı Soyadı"),
                ),
                TextField(
                  controller: _cvvController,
                  decoration: InputDecoration(hintText: "CVV"),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  child: Text("Ödeme Yap"),
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF006400), // arka plan rengi
                  ),
                  onPressed: () => _odemeYap(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PaymentSuccessPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF800000),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.grey,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Image.asset(
                  "assets/images/scooter.png",
                  width: 150,
                  height: 150,
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Ödeme başarılı!",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            Text(
              "Siparişiniz yola çıkıyor..",
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
