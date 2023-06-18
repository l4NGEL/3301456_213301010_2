import 'package:flutter/material.dart';
import '../../model/product_model.dart';
import 'cart_page.dart';

class FavoriUrunler extends StatefulWidget {
  @override
  _FavoriUrunlerState createState() => _FavoriUrunlerState();
}

class _FavoriUrunlerState extends State<FavoriUrunler> {
  List<Product> _favoriUrunler = [    products[2], // Omega-3
    products[0],products[42],products[43] // Parol
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF800000),
        title: Text("Favori Ürünler"),
      ),
      body: ListView.builder(
        itemCount: _favoriUrunler.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_favoriUrunler[index].name),
            subtitle: Text(_favoriUrunler[index].category),
            trailing: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
              ),

              onPressed: () {
                _favoriUrunler[index].addToCart();
                CartPage.sepetUrunler.add(_favoriUrunler[index]); // Ürünü sepete ekle ve sepette göster
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CartPage()),
                );
              },
              child: Text(
                "Sepete Ekle",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            onTap: () {
              // Tıklanılan ürünün detay sayfasına yönlendirme kodu buraya yazılabilir
            },
          );
        },
      ),
    );
  }
}