import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddressPage extends StatefulWidget {
  @override
  _AddressPageState createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _zipController = TextEditingController();

  late SharedPreferences _prefs;

  List<Address> _addressList = [];

  @override
  void initState() {
    super.initState();
    _loadAddresses();
  }

  void _loadAddresses() async {
    _prefs = await SharedPreferences.getInstance();
    final addresses = _prefs.getStringList('addresses');
    if (addresses != null) {
      setState(() {
        _addressList = addresses.map((a) => Address.fromString(a)).toList();
      });
    }
  }

  void _saveAddress() {
    final address = Address(
      name: _nameController.text,
      address: _addressController.text,
      city: _cityController.text,
      state: _stateController.text,
      zip: _zipController.text,
    );

    setState(() {
      _addressList.add(address);
    });

    _prefs.setStringList(
      'addresses',
      _addressList.map((a) => a.toString()).toList(),
    );

    _nameController.clear();
    _addressController.clear();
    _cityController.clear();
    _stateController.clear();
    _zipController.clear();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Address saved!'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF800000),
          title: Text('Addresses'),
        ),
        body: SingleChildScrollView(
            child: Form(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
              Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _addressController,
                decoration: InputDecoration(
                  labelText: 'Adres',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _cityController,
                decoration: InputDecoration(
                  labelText: 'şehir',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _stateController,
                decoration: InputDecoration(
                  labelText: 'Ülke',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _zipController,
                decoration: InputDecoration(
                  labelText: 'Posta Kodu',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: _saveAddress,
                child: Text('Save'),
                style:ElevatedButton.styleFrom(primary: Color(0xFF006400)),
              ),
            ),
            SizedBox(height: 16.0),
            if (_addressList.isNotEmpty) ...[
    Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8.0),
    child: Text(
    'Saved Addresses',
    style: Theme.of(context).textTheme.headline6
    ),
    ),
              SizedBox(height: 16.0),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: _addressList.length,
                itemBuilder: (BuildContext context, int index) {
                  final address = _addressList[index];
                  return Card(
                    margin: EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 4.0,
                    ),
                    child: ListTile(
                      title: Text(address.name),
                      subtitle: Text('${address.address}, ${address.city}, ${address.state}, ${address.zip}'),
                    ),
                  );
                },
              ),
            ],
                  ],
              ),
            ),
        ),
    );
  }
}

class Address {
  final String name;
  final String address;
  final String city;
  final String state;
  final String zip;

  Address({
    required this.name,
    required this.address,
    required this.city,
    required this.state,
    required this.zip,
  });

  factory Address.fromString(String str) {
    final parts = str.split(',');
    return Address(
      name: parts[0],
      address: parts[1],
      city: parts[2],
      state: parts[3],
      zip: parts[4],
    );
  }

  @override
  String toString() {
    return '$name,$address,$city,$state,$zip';
  }
}