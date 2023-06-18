import 'package:e_health_project/pages/home_screen/favorite.dart';
import 'package:e_health_project/pages/splash_screen/baby_care_page.dart';
import 'package:e_health_project/pages/splash_screen/cosmetic_page.dart';
import 'package:e_health_project/pages/splash_screen/health_product_page.dart';
import 'package:e_health_project/pages/splash_screen/medical_equipment.dart';
import 'package:e_health_project/pages/splash_screen/medical_page.dart';
import 'package:e_health_project/pages/splash_screen/mevcut_ilaclar.dart';
import 'package:e_health_project/pages/splash_screen/personel_care.dart';
import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text('Kategoriler'),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
          ),
          _buildAnimatedListTile(
            index: 0,
            title: 'Hızlı Al Ürünleri',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MevcutIlaclar()),
              );
            },
          ),
          _buildAnimatedListTile(
            index: 1,
            title: 'Favori Ürünler',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FavoriUrunler()),
              );
            },
          ),
          _buildAnimatedListTile(
            index: 1,
            title: 'İlaçlar',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MedicinePage()),
              );
            },
          ),
          _buildAnimatedListTile(
            index: 2,
            title: 'Kozmetik Ürünler',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CosmeticPage()),
              );
            },
          ),
          _buildAnimatedListTile(
            index: 3,
            title: 'Kişisel Bakım',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PersonelCarePage()),
              );
            },
          ),
          _buildAnimatedListTile(
            index: 4,
            title: 'Tıbbi Malzemeler',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MedicalEquipmentPage()),
              );
            },
          ),
          _buildAnimatedListTile(
            index: 5,
            title: 'Sağlık Ürünleri',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HealthProductsPage()),
              );
            },
          ),
          _buildAnimatedListTile(
            index: 6,
            title: 'Bebek Bakım Ürünleri',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BabyCarePage()),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedListTile({
    required int index,
    required String title,
    required VoidCallback onTap,
  }) {
    return FutureBuilder(
      future: Future.delayed(Duration(milliseconds: index * 100)),
      builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox.shrink();
        }
        return ListTile(
          leading: Icon(
            Icons.add,
            color: Colors.black,
          ),
          title: Text(title),
          onTap: onTap,
        );
      },
    );
  }
}
