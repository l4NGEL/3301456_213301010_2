import 'package:e_health_project/pages/profile_screen/card_info_page.dart';
import 'package:flutter/material.dart';
import '../home_screen/Health_history_page.dart';
import '../profile_screen/address_information.dart';
import '../profile_screen/blood_test_page.dart';
import '../profile_screen/hakkimizda.dart';
import '../profile_screen/personel_data.dart';


class Profile extends StatelessWidget {

  Profile();

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
          "Profil",
          style: TextStyle(
            color: Colors.black,
            fontSize: 28,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage:
                  AssetImage('assets/images/avatar.png'),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.person_search_outlined),
            title: Text('Sağlık geçmişi'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HealthHistoryCard()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Adres Bilgisi'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddressPage()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.add_card_outlined),
            title: Text('Kart Bilgileri'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CardInfoPage()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.bloodtype),
            title: Text('Kan Tahlilleri'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BloodTestScreen(personName: "")),
              );
            },
          ),
            ListTile(
            leading: Icon(Icons.person),
            title: Text('Kişisel Bilgiler'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PersonDataPage(),
              ));
            },
          ),
          ListTile(
            leading: Icon(Icons.info_outline),
            title: Text('Hakkımızda'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HakkimizdaPage()),
              );
            },
          ),

          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Çıkış Yap'),
           // onTap: () => _logout(context),
          ),
        ],
      ),
    );
  }
}
