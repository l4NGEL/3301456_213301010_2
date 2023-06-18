import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:e_health_project/helpers/database_helpers.dart';

class MedicineScreen extends StatefulWidget {
  @override
  _MedicineScreenState createState() => _MedicineScreenState();
}

class _MedicineScreenState extends State<MedicineScreen> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  TextEditingController nameController = TextEditingController();
  TextEditingController dosageController = TextEditingController();
  List<Map<String, dynamic>> medicines = [];

  @override
  void initState() {
    super.initState();
    initializeNotifications();
    initializeDatabase();
    tz.initializeTimeZones();
  }

  Future<void> initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('app_icon');
    final InitializationSettings initializationSettings =
    InitializationSettings(android: initializationSettingsAndroid);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }
  Future<void> deleteMedicine(int index) async {
    final Map<String, dynamic> medicine = medicines[index];
    final int id = medicine['id'];

    await DatabaseHelper.instance.deleteMedicine(id);
    cancelNotification(id);

    setState(() {
      medicines.removeAt(index);
    });
  }

  Future<void> initializeDatabase() async {
    final List<Map<String, dynamic>> savedMedicines =
    await DatabaseHelper.instance.getMedicines();
    setState(() {
      medicines = savedMedicines;
    });
  }

  Future<void> showNotification(
      int id, String title, String body, DateTime scheduledTime) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'medicine_reminder_channel',
      'Medicine Reminder',
      importance: Importance.high,
      priority: Priority.high,
    );
    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduledTime, tz.local),
      platformChannelSpecifics,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  Future<void> cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  Future<void> saveMedicine() async {
    final String name = nameController.text;
    final int dosage = int.tryParse(dosageController.text) ?? 0;

    if (name.isEmpty || dosage <= 0) {
      return;
    }

    final Map<String, dynamic> medicine = {
      'name': name,
      'dosage': dosage,
      'isTaken': 0,
    };

    final int id = await DatabaseHelper.instance.insertMedicine(medicine);
    setState(() {
      medicine['id'] = id;
      medicines.add(medicine);
    });

    // İlaç alım saatlerine göre bildirimleri ayarlayın
    final DateTime now = DateTime.now();
    final DateTime today = DateTime(now.year, now.month, now.day);
    final DateTime tomorrow = today.add(Duration(days: 1));

    final List<DateTime> dosageTimes = getDosageTimes(now, dosage);
    dosageTimes.forEach((time) {
      if (time.isAfter(now)) {
        showNotification(id, 'Medicine Reminder', 'Time to take $name!', time);
      }
    });
  }

  List<DateTime> getDosageTimes(DateTime startTime, int dosage) {
    final List<DateTime> dosageTimes = [];
    final Duration interval = Duration(hours: 24 ~/ dosage);

    for (int i = 0; i < dosage; i++) {
      final DateTime time = startTime.add(interval * i);
      dosageTimes.add(time);
    }

    return dosageTimes;
  }

  Future<void> toggleMedicineTaken(int index) async {
    final Map<String, dynamic> medicine = medicines[index];
    final int id = medicine['id'];
    final bool isTaken = medicine['isTaken'] == 1;

    final int updatedIsTaken = isTaken ? 0 : 1;
    medicine['isTaken'] = updatedIsTaken;

    await DatabaseHelper.instance
        .updateMedicine({'id': id, 'isTaken': updatedIsTaken});

    if (isTaken) {
      cancelNotification(id);
    } else {
      final String name = medicine['name'];
      final int dosage = medicine['dosage'];
      final DateTime now = DateTime.now();

      final List<DateTime> dosageTimes = getDosageTimes(now, dosage);
      dosageTimes.forEach((time) {
        if (time.isAfter(now)) {
          showNotification(id, 'Medicine Reminder', 'Time to take $name!', time);
        }
      });
    }

    setState(() {});
  }


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
          "İlaç Hatırlatma",
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'İlaç ismini giriniz ',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: dosageController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Günde kaç kez alınması gerektiğini giriniz',
              ),
            ),
          ),
          ElevatedButton(
            onPressed: saveMedicine,
            style: ElevatedButton.styleFrom(primary: Colors.deepOrange),
            child: const Text('Kaydet'),
          ),
          Text('Günlük almanız gereken ilaçlar',style:TextStyle(fontSize: 20,fontWeight:FontWeight.bold,color: Colors.teal )),
          const SizedBox(height: 16.0),
          Expanded(
            child: ListView.builder(
              itemCount: medicines.length,
              itemBuilder: (BuildContext context, int index) {
                final Map<String, dynamic> medicine = medicines[index];
                final String name = medicine['name'];
                final int dosage = medicine['dosage'];
                final bool isTaken = medicine['isTaken'] == 1;

                return Dismissible(
                  key: Key(medicine['id'].toString()),
                  direction: DismissDirection.startToEnd,
                  background: Container(
                    alignment: AlignmentDirectional.centerStart,
                    color: Colors.red,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
                      child: Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  onDismissed: (direction) {
                    deleteMedicine(index);
                  },
                  child: ListTile(
                    title: Text(name),
                    subtitle: Text('Dosage: $dosage'),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
