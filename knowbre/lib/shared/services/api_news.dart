import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:knowbre/shared/models/article.dart';

class ApiService {
  final endPointUrl = "newsapi.org";
  final client = http.Client();

  Future<List<Article>> getArticle() async {
    final queryParameters = {
      'q': 'educação',
      'language': 'pt',
      'sortBy': 'relevancy',
      'apiKey': 'b2b99087b51348668586453b98783eae'
    };

    final uri = Uri.https(endPointUrl, '/v2/everything', queryParameters);
    final response = await client.get(uri);
    Map<String, dynamic> json = jsonDecode(response.body);
    List<dynamic> body = json['articles'];
    List<Article> articles =
        body.map((dynamic item) => Article.fromJson(item)).toList();
    return articles;
  }
}
