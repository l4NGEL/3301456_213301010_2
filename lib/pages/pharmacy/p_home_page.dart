import 'package:e_health_project/pages/home_screen/code_page.dart';
import 'package:e_health_project/pages/pharmacy/add_medicine.dart';
import 'package:flutter/material.dart';


class EczaneAnaSayfa extends StatefulWidget {
  @override
  _EczaneAnaSayfaState createState() => _EczaneAnaSayfaState();
}

class _EczaneAnaSayfaState extends State<EczaneAnaSayfa> {
  int _selectedIndex = 0;

  List<Widget> _pages = [
    PharmacyScreen(),
    IlacSorguPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.inventory),
            label: 'Stok Durumu Sorgulama',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt),
            label: 'Kod Sorgulama',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.teal,
        onTap: _onItemTapped,
      ),
    );
  }
}

