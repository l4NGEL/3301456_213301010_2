import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsDetails extends StatefulWidget {
  final dynamic article;

  NewsDetails({required this.article});

  @override
  _NewsDetailsState createState() => _NewsDetailsState();
}

class _NewsDetailsState extends State<NewsDetails> {
  void launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final article = widget.article;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF800000),
        title: Text(
          'Haber Detayları',
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.network(
                  article['urlToImage'] ?? '',
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 20),
              Text(
                article['title'] ?? '',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                article['content'] ?? '',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 20),
              Text(
                'Haberin devamı..',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              InkWell(
                child: Text(
                  article['url'] ?? '',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
                onTap: () => launchUrl(article['url'] ?? ''),
              ),
            ],
          ),
        ),
      ),
      // Implement swipe up gesture to go back
      bottomNavigationBar: Dismissible(
        key: const Key('dismiss'),
        direction: DismissDirection.up,
        onDismissed: (direction) {
          Navigator.of(context).pop();
        },
        child: Container(
          color: Colors.transparent,
          height: 50,
        ),
      ),
    );
  }
}
//swipe up gestures