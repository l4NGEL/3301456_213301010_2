import 'package:flutter/material.dart';
import 'package:sensors/sensors.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StepCounterPage extends StatefulWidget {
  @override
  _StepCounterPageState createState() => _StepCounterPageState();
}

class _StepCounterPageState extends State<StepCounterPage> {
  int _stepCount = 0;
  double _distance = 0;
  double adimUzunlugu = 0.7; // Adım uzunluğunu kendinize göre ayarlayın
  double _progress = 0;
  List<charts.Series<WalkData, DateTime>>? _chartData;
  CollectionReference _walkDataCollection =
  FirebaseFirestore.instance.collection('walk_data');

  @override
  void initState() {
    super.initState();
    accelerometerEvents.listen((AccelerometerEvent event) {
      if (event.y > 15) {
        setState(() {
          _stepCount++;
          _distance = _stepCount * adimUzunlugu;
          _progress = _stepCount / 10000;
          _saveWalkDataToFirebase();
        });
      }
    });
    _initializeChartData();
  }

  void _saveWalkDataToFirebase() async {
    DateTime now = DateTime.now();
    await _walkDataCollection.add({
      'date': now,
      'steps': _stepCount,
    });
  }

  void _initializeChartData() async {
    DateTime now = DateTime.now();
    List<WalkData> data = [];
    QuerySnapshot walkDataSnapshot = await _walkDataCollection
        .where('date',
        isGreaterThan: DateTime(now.year, now.month, now.day - 6))
        .get();
    walkDataSnapshot.docs.forEach((doc) {
      Timestamp timestamp = doc['date'];
      data.add(WalkData(
        date: timestamp.toDate(),
        steps: doc['steps'],
      ));
    });
    setState(() {
      _chartData = [
        charts.Series<WalkData, DateTime>(
          id: 'Yürüme',
          colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
          domainFn: (WalkData walkData, _) => walkData.date,
          measureFn: (WalkData walkData, _) => walkData.steps,
          data: data,
        ),
      ];
    });
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
        title: Text("Adım Sayar",style: TextStyle(color:Colors.blueGrey,fontSize: 25),),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 10),
              CircularPercentIndicator(
                radius: 130,
                lineWidth: 20,
                percent: _progress,
                center: Text(
                  '$_stepCount',
                  style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                ),
                progressColor: Colors.green,
                backgroundColor: Colors.grey,
              ),
              SizedBox(height: 20),
              Text(
                'Yürünülen Mesafe: $_distance',
                style: TextStyle(fontSize: 18,color: Colors.green),
              ),
              SizedBox(height: 20),
              if (_chartData != null)
                Container(
                  height: 200,
                  padding: EdgeInsets.all(16),
                  child: charts.TimeSeriesChart(
                    _chartData!,
                    animate: true,
                    dateTimeFactory: const charts.LocalDateTimeFactory(),
                  ),
                ),
              if (_chartData == null)
                CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}

class WalkData {
  final DateTime date;
  final int steps;

  WalkData({required this.date, required this.steps});
}
