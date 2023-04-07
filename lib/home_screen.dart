import 'package:flutter/material.dart';
import 'package:flutternews/newsArticle.dart';
import 'fetch_data.dart';
import 'package:colorful_safe_area/colorful_safe_area.dart';

class Home extends StatelessWidget {
  final NewsApiProvider _newsApiProvider = NewsApiProvider();

  @override
  Widget build(BuildContext context) {
    return ColorfulSafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text('Flutter News',
              style: TextStyle(
                color: Colors.black
              ),
            ),
          ),
          elevation: 0,
          backgroundColor: Colors.green[100],
        ),
        body: Card(
          child: FutureBuilder(
            future: _newsApiProvider.fetchNewsArticles(),
            builder: (BuildContext context, AsyncSnapshot<List<NewsArticle>> snapshot) {
              if (snapshot.hasData) {
                final newsArticles = snapshot.data!;
                return  ListView.builder(
                  itemCount: newsArticles.length,
                  itemBuilder: (context, index) {
                    final article = newsArticles[index];
                    return Card(
                      margin: EdgeInsets.all(8.0),
                      elevation: 4.0,
                      child: InkWell(
                        onTap: () {
                          // navigate to article detail screen

                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: double.infinity,
                              height: 200,
                              child: Image.network(
                                article.imageUrl,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    article.title,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  SizedBox(height: 8.0),
                                  Text(
                                    article.url,
                                    style: TextStyle(

                                    ),
                                  ),
                                  SizedBox(height: 8.0),
                                  Text(
                                    article.description,
                                    style: TextStyle(fontSize: 14.0),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
          color: Colors.grey[100],
        ),
      ),
    );
  }
}





