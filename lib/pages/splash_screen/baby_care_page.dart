import 'package:flutter/material.dart';
import '../../model/product_model.dart';
import 'product_details_page.dart';

class BabyCarePage extends StatefulWidget {
  const BabyCarePage({Key? key}) : super(key: key);

  @override
  State<BabyCarePage> createState() => _BabyCarePageState();
}

class _BabyCarePageState extends State<BabyCarePage> {
  List<Product> _babyCare = [
    products[3],
    products[4],
    products[5],
    products[37],
    products[28],
    products[39],
    products[40],
    products[41],
  ];


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
        title: Text("Bebek Bakım Ürünleri",style: TextStyle(color:Colors.black,fontSize: 28,),),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: GridView.count(
        crossAxisCount: 2, // Elemanların yatayda 2 sütun olacak şekilde yerleştirilmesi
        childAspectRatio: 0.7, // Elemanların boy/en oranını ayarla
        children: _babyCare.map((product) => Padding(
          padding: EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DetailsPage(product: product)),
              );
            },
            child: Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: Image.asset(
                      product.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                        Text(
                          product.category,
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.grey[600],
                          ),
                        ),
                        Text(
                          product.price.toString() + " TL",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        )).toList(),
      ),
    );
  }
}