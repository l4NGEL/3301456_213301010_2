import 'package:flutter/material.dart';
class HealthHistoryResultPage extends StatelessWidget {
  final List<String> diseases;
  final String otherDisease;
  final String medications;

  HealthHistoryResultPage({required this.diseases, required this.otherDisease, required this.medications});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
        backgroundColor: Color(0xFF800000),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.add_circle_outline, size: 40),
                  Text(
                    "Sağlık Geçmişi",
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Text("Hastalıkları: ${diseases.join(", ")}",style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.black38),),
              SizedBox(height: 10),
              Visibility(
                visible: diseases.contains("Other"),
                child: Text("Other Disease: $otherDisease"),
              ),
              SizedBox(height: 10),
              Text("kullandığı ilaçlar: $medications",style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.black38),),
            ],
          ),
        ),
      ),
    );
  }
}
