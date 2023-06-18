import 'package:flutter/material.dart';

class HakkimizdaPage extends StatefulWidget {
  @override
  _HakkimizdaPageState createState() => _HakkimizdaPageState();
}

class _HakkimizdaPageState extends State<HakkimizdaPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xFF800000),
            title: Text('Hakkında'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Center(
              child:
              Text(
                'Bu uygulama Dr. Öğretim Üyesi Ahmet Cevahir ÇINAR tarafından yürütülen 3301456 kodlu MOBİL PROGRAMLAMA dersi kapsamında 213301010 numaralı Beyza Nur KILIÇ tarafından 23 Haziran 2023 günü yapılmıştır.',
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ));
  }
}