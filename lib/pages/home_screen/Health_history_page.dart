import 'package:flutter/material.dart';
import 'health_history_result_page.dart';

class HealthHistoryCard extends StatefulWidget {
  const HealthHistoryCard({Key? key}) : super(key: key);

  @override
  _HealthHistoryCardState createState() => _HealthHistoryCardState();
}

class _HealthHistoryCardState extends State<HealthHistoryCard> {
  List<String> _diseases = [];
  String _otherDisease = "";
  String _medications = "";

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
// Navigate back to previous screen
          Navigator.pop(context);
          return false;
        },
        /*WillPopScope widget'i, bu varsayılan davranışı değiştirerek, geri tuşuna basıldığında yapılacak işlemleri kontrol etmenize olanak sağlar.*/
        child: Scaffold(
        appBar: AppBar(
        title: Text("Sağlık Geçmişi"),
            backgroundColor: Color(0xFF800000),

          actions: [
            IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HealthHistoryResultPage(
                      diseases: _diseases,
                      otherDisease: _otherDisease,
                      medications: _medications,
                    ),
                  ),
                );
              },
            ),

        ],),
    body: SingleChildScrollView(
    child: Card(
    child: Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [


    SizedBox(height: 10),
    Text("Herhangi bir sağlık sorununuz var mı?",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),
    CheckboxListTile(
    title: Text("Kanser"),
    value: _diseases.contains("Kanser"),
    onChanged: (value) {
    setState(() {
    if (value!) {
    _diseases.add("Kanser");
    } else {
    _diseases.remove("Kanser");
    }
    });
    },
    ),
    CheckboxListTile(
    title: Text("Diyabet"),
    value: _diseases.contains("Diyabet"),
    onChanged: (value) {
    setState(() {
    if (value!) {
    _diseases.add("Diyabet");
    } else {
    _diseases.remove("Diyabet");
    }
    });
    },
    ),
    CheckboxListTile(
    title: Text("Kalp Rahatsızlığı"),
    value: _diseases.contains("Kalp Rahatsızlığı"),
    onChanged: (value) {
    setState(() {
    if (value!) {
    _diseases.add("Kalp Rahatsızlığı");
    } else {
    _diseases.remove("Kalp Rahatsızlığı");
    }
    });
    },
    ),
    CheckboxListTile(
    title: Text("Yüksek Tansiyon"),
    value: _diseases.contains("Yüksek Tansiyon"),
    onChanged: (value) {
    setState(() {
    if (value!) {
    _diseases.add("Yüksek Tansiyon");
    } else {
    _diseases.remove("Yüksek Tansiyone");
    }
    });
    },
    ),
    CheckboxListTile(
    title: Text("Yüksek Kolestrol"),
    value: _diseases.contains("Yüksek Kolestrol"),
    onChanged: (value) {
    setState(() {
    if (value!) {
    _diseases.add("Yüksek Kolestrol");
    } else {
    _diseases.remove("Yüksek Kolestrol");
    }
    });
    },
    ),
    CheckboxListTile(
              title: Text("Böbrek Rahatsızlığı"),
              value: _diseases.contains("Böbrek Rahatsızlığı"),
              onChanged: (value) {
                setState(() {
                  if (value!) {
                    _diseases.add("Böbrek Rahatsızlığı");
                  } else {
                    _diseases.remove("Böbrek Rahatsızlığı");
                  }
                });
              },
            ),
            CheckboxListTile(
              title: Text("karaciğer hastalığı"),
              value: _diseases.contains("karaciğer hastalığı"),
              onChanged: (value) {
                setState(() {
                  if (value!) {
                    _diseases.add("karaciğer hastalığı");
                  } else {
                    _diseases.remove("karaciğer hastalığı");
                  }
                });
              },
            ),
            CheckboxListTile(
              title: Text("Tiroid Rahatsızlığı"),
              value: _diseases.contains("Tiroid Rahatsızlığı"),
              onChanged: (value) {
                setState(() {
                  if (value!) {
                    _diseases.add("Tiroid Rahatsızlığı");
                  } else {
                    _diseases.remove("Tiroid Rahatsızlığı");
                  }
                });
              },
            ),
            CheckboxListTile(
              title: Text("Diğer"),
              value: _diseases.contains("Diğer"),
              onChanged: (value) {
                setState(() {
                  if (value!) {
                    _diseases.add("Diğer");
                  } else {
                    _diseases.remove("Diğer");
                  }
                });
              },
            ),
            SizedBox(height: 10),
            Visibility(
              visible: _diseases.contains("Diğer"),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: "Lütfen belirtiniz",
                ),
                onChanged: (value) {
                  setState(() {
                    _otherDisease = value;
                  });
                },
              ),
            ),
            SizedBox(height: 10),
            Text("Kullandığı ilaçlar",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600)),
            TextFormField(
              decoration: InputDecoration(
                hintText: "Lütfen şu anda kullanmakta olduğunuz ilaçları yazınız.",
              ),
              onChanged: (value) {
                setState(() {
                  _medications = value;
                });
              },
            ),
          ],
        ),
    )
    )
    )
        )
    );
    }
}
