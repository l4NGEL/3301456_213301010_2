import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'new_detail_page.dart';

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  List<dynamic> articles = [];

  @override
  void initState() {
    super.initState();
    getNews();
  }

  void getNews() async {
    final String apiKey = '8b76b1130c074e049aeaeb06d9b02f7e';
    final String baseUrl = 'https://newsapi.org/v2';
    final String endpoint = '/everything';

    final String url =
        '$baseUrl$endpoint?q=eczane&apiKey=$apiKey&language=tr&sortBy=publishedAt';

    final response = await http.get(Uri.parse(url));

    setState(() {
      articles = jsonDecode(response.body)['articles'];
    });
  }

  void launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
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
          "Haberler",
          style: TextStyle(
            color: Colors.red[600],
            fontSize: 24,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: articles.length,
        itemBuilder: (BuildContext context, int index) {
          final article = articles[index];
          return GestureDetector(
            onScaleUpdate: (ScaleUpdateDetails details) {
              // ScaleUpdateDetails ile ölçeklendirme bilgilerini alabilirsiniz
              setState(() {
                // Örneğin, metin boyutunu ölçek faktörüne bağlı olarak güncelleyebilirsiniz
                final scale = details.scale;
                final newTextSize = 16.0 * scale; // Ölçek faktörüne göre yeniden boyutlandırma
                // Metin boyutunu güncelle
                // Örneğin, article['title'] ve article['description'] için aşağıdaki gibi yapabilirsiniz:
                article['titleFontSize'] = newTextSize;
                article['descriptionFontSize'] = newTextSize;
              });
            },
            child: Card(
              child: ListTile(
                title: Text(
                  article['title'],
                  style: TextStyle(
                    fontSize: article['titleFontSize'] ?? 16.0, // Varsayılan metin boyutu
                  ),
                ),
                subtitle: Text(
                  article['description'],
                  style: TextStyle(
                    fontSize: article['descriptionFontSize'] ?? 14.0, // Varsayılan metin boyutu
                  ),
                ),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NewsDetails(article: article),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
