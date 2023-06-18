import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

Future<Eczane> fetchEczane() async {
  final response = await http.get(
    Uri.parse(
        'https://api.collectapi.com/health/dutyPharmacy?ilce=Tavşanlı&il=Kütahya'),
    headers: {
      HttpHeaders.contentTypeHeader:"application/json",
      HttpHeaders.authorizationHeader: 'apikey 0fiYTalAWgYj1cMT2HevSj:16d37J5avm2PRpZ1ugkDDA',
    },
  );

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Eczane.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class Eczane {
  bool? success;
  List<Result>? result;

  Eczane({this.success, this.result});

  Eczane.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['result'] != null) {
      result = <Result>[];
      json['result'].forEach((v) {
        result!.add(Result.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['success'] = success;
    if (result != null) {
      data['result'] = result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Result {
  String? name;
  String? dist;
  String? address;
  String? phone;
  String? loc;

  Result({this.name, this.dist, this.address, this.phone, this.loc});

  Result.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    dist = json['dist'];
    address = json['address'];
    phone = json['phone'];
    loc = json['loc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['dist'] = this.dist;
    data['address'] = this.address;
    data['phone'] = this.phone;
    data['loc'] = this.loc;
    return data;
  }
}


class NobetciEczanePage extends StatefulWidget {
  const NobetciEczanePage({super.key});

  @override
  State<NobetciEczanePage> createState() => _NobetciEczanePageState();
}

class _NobetciEczanePageState extends State<NobetciEczanePage> {
  late Future<Eczane> futureEczane;

  @override
  void initState() {
    super.initState();
    futureEczane = fetchEczane();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back,color: Colors.black,),
            onPressed: () {
              Navigator.pop(context); // Geri düğmesi işlevselliği
            },
          ),
          title: Text(
            "Nöbetçi Eczane",
            style: TextStyle(
              color: Colors.black,
              fontSize: 24,
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Center(
          child: FutureBuilder<Eczane>(
            future: futureEczane,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                print(snapshot.data!.result![0].name);

                return Center( // Wrap with Center widget
                  child: ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: snapshot.data?.result?.length ?? 0,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Name: ${snapshot.data?.result?[index].name ?? ''}',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'City: ${snapshot.data?.result?[index].dist ?? ''}',
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Address: ${snapshot.data?.result?[index].address ?? ''}',
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Phone: ${snapshot.data?.result?[index].phone ?? ''}',
                            ),
                            SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () {
                                _launchMapsApp(snapshot.data?.result?[index].loc);
                              },
                              child: Text('Haritada Göster'),
                              style: ElevatedButton.styleFrom(primary: Colors.red),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );Text(snapshot.data!.result.toString());
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
void _launchMapsApp(String? location) async {
  if (location != null) {
    final url = 'https://www.google.com/maps/search/?api=1&query=$location';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

