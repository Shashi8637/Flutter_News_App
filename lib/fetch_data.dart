import 'dart:convert';
import 'package:http/http.dart' as http;
import 'newsArticle.dart';
class NewsApiProvider {
  static const String _baseUrl = 'https://newsapi.org/v2/';
  static const String _apiKey = 'f1761060aad74440b704eafdd76228bf';

  Future<List<NewsArticle>> fetchNewsArticles() async {
    final response = await http.get(Uri.parse(
      _baseUrl +
          'everything?q=tesla&from=2023-03-07&sortBy=publishedAt&apiKey=$_apiKey',
    ));
    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = jsonDecode(response.body)['articles'];
      return jsonResponse.map((data) => NewsArticle.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load news articles');
    }
  }
}
