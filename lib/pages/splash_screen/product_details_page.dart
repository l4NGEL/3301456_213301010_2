import 'package:flutter/material.dart';
import '../../model/product_model.dart';
import '../home_screen/cart_page.dart';


class DetailsPage extends StatefulWidget {
  final Product product;

  const DetailsPage({Key? key, required this.product}) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  int _quantity = 1;

  void _incrementQuantity() {
    setState(() {
      _quantity++;
    });
  }

  void _decrementQuantity() {
    setState(() {
      if (_quantity > 1) {
        _quantity--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Ürün Detayları",
          style: TextStyle(
            color: Colors.black,
            fontSize: 28,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: Image.asset(
              widget.product.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.product.name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  widget.product.price.toString() + " TL",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    color: Colors.red,
                  ),
                ),
                SizedBox(height: 1.0),
                Row(
                  children: [
                    Text(
                      "Adet: ",
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                    IconButton(
                      onPressed: _decrementQuantity,
                      icon: Icon(Icons.remove),
                    ),
                    Text(
                      _quantity.toString(),
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                    IconButton(
                      onPressed: _incrementQuantity,
                      icon: Icon(Icons.add),
                    ),
                  ],
                ),
                SizedBox(height: 3.0),
                ElevatedButton(
                  onPressed: () {
                    widget.product.quantity = _quantity;
                    widget.product.addToCart();
                    CartPage.sepetUrunler.add(widget.product);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CartPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                  ),
                  child: Text(
                    "Sepete Ekle",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  widget.product.description,
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
