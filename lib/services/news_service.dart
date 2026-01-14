import 'dart:convert';
import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/models/news_response_model.dart';

class NewsService {
  Future<NewsResponseModel> getTopHeadlines() async {
    final apiKey = dotenv.env['NEWS_API_KEY'];

    final url = Uri.parse(
      'https://newsapi.org/v2/top-headlines/?country=us&apiKey=$apiKey',
    );

    final response = await http.get(url);

    try {
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] != 'ok') {
          throw Exception(data['message']);
        }
        return NewsResponseModel.fromMap(data);
      } else {
        throw Exception('Failed to load news');
      }
    } catch (e) {
      log('Error in NewsService: $e');
      throw Exception('Terjadi kesalahan: $e');
    }
  }
}
