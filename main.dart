import 'package:codelab_dua/webviewscreen.dart';
import 'package:flutter/material.dart';

import 'apiservice.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: NewsListScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class NewsListScreen extends StatefulWidget {
  @override
  _NewsListScreenState createState() => _NewsListScreenState();
}

class _NewsListScreenState extends State<NewsListScreen> {
  final NewsApiService newsApiService = NewsApiService();
  List<dynamic> articles = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchNews();
  }

  void fetchNews() async {
    final fetchedArticles = await newsApiService.fetchBitcoinNews();
    setState(() {
      articles = fetchedArticles;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CODELAP - API'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WebViewScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: articles.length,
              itemBuilder: (context, index) {
                final article = articles[index];
                return ListTile(
                  leading: article['urlToImage'] != null
                      ? Image.network(
                          article['urlToImage'],
                          width: 100,
                          fit: BoxFit.cover,
                        )
                      : Container(
                          width: 100,
                          color: Colors.grey,
                          child: Icon(Icons.image),
                        ),
                  title: Text(
                    article['title'] ?? 'No Title',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    article['description'] ?? 'No Description',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  onTap: () {
                    if (article['url'] != null) {
                      print('Open: ${article['url']}');
                    }
                  },
                );
              },
            ),
    );
  }
}
