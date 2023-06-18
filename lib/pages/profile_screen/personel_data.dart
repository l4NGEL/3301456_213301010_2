import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PersonDataPage extends StatefulWidget {
  @override
  _PersonDataPageState createState() => _PersonDataPageState();
}

class _PersonDataPageState extends State<PersonDataPage> {
  String _firstName = "";
  String _bloodType = "";
  String _birthDate = "";
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _bloodTypeController = TextEditingController();
  TextEditingController _birthDateController = TextEditingController();
  List<String> _personDataList = [];

  @override
  void initState() {
    super.initState();
    // SharedPreferences'den kayıtlı verileri al
    _getSavedPersonData();
  }

  void _getSavedPersonData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? personDataList = prefs.getStringList('personDataList');
    if (personDataList != null) {
      setState(() {
        _personDataList = personDataList;
      });
    }
  }
  void _removePersonData(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _personDataList.removeAt(index);
    });
    await prefs.setStringList('personDataList', _personDataList);
  }

  void _savePersonDataToSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _firstName = _firstNameController.text;
    _bloodType = _bloodTypeController.text;
    _birthDate = _birthDateController.text;

    String personData = "Ad: $_firstName, Kan grubu: $_bloodType, Doğum Tarihi: $_birthDate";
    _personDataList.add(personData);
    await prefs.setStringList('personDataList', _personDataList);
    _firstNameController.clear();
    _bloodTypeController.clear();
    _birthDateController.clear();
    setState(() {});
  }

  Widget _buildPersonDataList() {
    return Expanded(
      child: ListView.builder(
        itemCount: _personDataList.length,
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
            key: Key(_personDataList[index]),
            onDismissed: (direction) {
              _removePersonData(index);
            },
            background: Container(
              color: Colors.red,
              child: Icon(Icons.delete, color: Colors.white),
              alignment: Alignment.centerRight,
              padding: EdgeInsets.only(right: 16.0),
            ),
            child: Card(
              child: ListTile(
                title: Text(_personDataList[index]),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kişisel Bilgiler'),
        backgroundColor: Color(0xFF800000),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          /*crossAxisAlignment: CrossAxisAlignment.stretch özelliği, belirtilen eksen boyunca tüm child widget'ların genişliğini genişletir. Yani, ekranda yatay olarak uzanan tüm widget'lar ekranda aynı genişliğe sahip olacak şekilde boyutlandırılır. Bu özellik, sütunlarda birden fazla child widget'a sahip olan düzenlemelerde özellikle yararlıdır, çünkü tüm widget'lar aynı genişliğe sahip olacak ve bu da daha düzenli bir görünüm sağlayacaktır.*/
          children: <Widget>[
          TextField(
          controller: _firstNameController,
          decoration: InputDecoration(labelText: 'Ad Soyadı'),
        ),
        TextField(
          controller: _bloodTypeController,
          decoration: InputDecoration(labelText: 'Kan grubu'),
        ),
        TextField(
              controller: _birthDateController,
              decoration: InputDecoration(labelText: 'Doğum Tarihi'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              child: Text('Kaydet'),
              style: ElevatedButton.styleFrom(primary: Color(0xFF006400)),
              onPressed: _savePersonDataToSharedPreferences,
            ),
            Text(
              'Kaydedilen Bilgiler:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            SizedBox(height: 8.0),
            _buildPersonDataList(),
          ],
        ),
      ),
    );
  }
}