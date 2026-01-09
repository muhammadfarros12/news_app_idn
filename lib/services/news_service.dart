import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class NewsService {
  Future<String> getTopHeadlines() async {
    final apiKey = dotenv.env['NEWS_API_KEY'];

    final url = Uri.parse(
      'https://newsapi.org/v2/top-headlines?country=us&apiKey=$apiKey',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['articles'][10]['title'];
    } else {
      throw Exception('Failed to load news');
    }
  }
}
