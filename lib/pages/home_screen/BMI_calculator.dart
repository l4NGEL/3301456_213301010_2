import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class BMIApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return MaterialApp(
      title: 'Vücut Kitle Endeksi',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: BMICalculator(),
    );
  }
}

class BMICalculator extends StatefulWidget {
  @override
  _BMICalculatorState createState() => _BMICalculatorState();
}

class _ChartData {
  final int index;
  final double bmi;

  _ChartData(this.index, this.bmi);
}

class _BMICalculatorState extends State<BMICalculator> {
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  double bmiResult = 0.0;
  String resultText = "";
  String weightRange = "";
  List<_ChartData> chartData = [];

  void calculateBMI() {
    double height = double.parse(heightController.text);
    double weight = double.parse(weightController.text);
    if (height > 0 && weight > 0) {
      double bmi = weight / (height * height);
      setState(() {
        bmiResult = bmi;
        if (bmi < 18.5) {
          resultText = "Zayıf";
        } else if (bmi >= 18.5 && bmi < 25) {
          resultText = "Normal";
        } else if (bmi >= 25 && bmi < 30) {
          resultText = "Fazla Kilolu";
        } else {
          resultText = "Obez";
        }

        double minHeight = 18.5 * height * height;
        double maxHeight = 24.9 * height * height;
        weightRange =
        "Önerilen Kilo Aralığı: ${minHeight.toStringAsFixed(1)} - ${maxHeight.toStringAsFixed(1)} kg";

        saveBMIResult(bmi, weightRange);
      });
    }
  }

  void saveBMIResult(double bmi, String weightRange) {
    FirebaseFirestore.instance
        .collection('bmi_results')
        .add({
      'bmi': bmi,
    })
        .then((value) => print('BMI sonucu kaydedildi'))
        .catchError((error) => print('Hata: $error'));

    int index = chartData.length;
    chartData.add(_ChartData(index, bmi));
  }

  List<charts.Series<_ChartData, int>> _createChartData() {
    return [
      charts.Series<_ChartData, int>(
        id: 'BMI',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (_ChartData data, _) => data.index,
        measureFn: (_ChartData data, _) => data.bmi,
        data: chartData,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context); // Geri düğmesi işlevselliği
          },
        ),
        title: Text(
          "Vücut Kitle Endeksi ",
          style: TextStyle(color: Colors.pink, fontSize: 25),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/slim-body.png'),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: Colors.grey),
                ),
                child: TextField(
                  controller: heightController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Boy (metre cinsinden)',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: Colors.grey),
                ),
                child: TextField(
                  controller: weightController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Kilo (kilogram cinsinden)',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.yellow,
                      Colors.pink,
                      Colors.purple,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: ElevatedButton(
                  onPressed: calculateBMI,
                  child: Text('Hesapla'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    minimumSize: Size(200, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    elevation: 0,
                    primary: Colors.transparent,
                    shadowColor: Colors.transparent,
                    side: BorderSide(
                      width: 2,
                      color: Colors.pink,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                'Sonuç: $bmiResult',
                style: TextStyle(fontSize: 20.0),
              ),
              Text(
                'Durum: $resultText',
                style: TextStyle(fontSize: 20.0),
              ),
              Text(
                weightRange,
                style: TextStyle(fontSize: 20.0),
              ),
              SizedBox(
                height: 200,
                child: charts.LineChart(
                  _createChartData(),
                  animate: true,
                  domainAxis: charts.NumericAxisSpec(
                    tickProviderSpec: charts.BasicNumericTickProviderSpec(
                      zeroBound: false,
                      desiredTickCount: 5,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
