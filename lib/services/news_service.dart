import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:news_app/models/news_response_model.dart';
import 'package:news_app/utils/constants.dart';

class NewsService {
  static const String _baseUrl = Constants.baseUrl;
  static final String _apiKey = Constants.apiKey;

  Future<NewsResponseModel> getTopHeadlines({
    String country = Constants.country,
    String? category,
    int page = 1,
    int pageSize = 20,
  }) async {
    try {
      final Map<String, dynamic> queryParams = {
        'apiKey': _apiKey,
        'country': country,
        'page': page.toString(),
        'pageSize': pageSize.toString(),
      };

      if (category != null && category.isNotEmpty) {
        queryParams['category'] = category;
      }

      final url = Uri.parse(
        '$_baseUrl${Constants.topHeadlines}',
      ).replace(queryParameters: queryParams);

      final response = await http.get(url);
      log(
        'Request URL: $url, Status Code: ${response.statusCode}, body: ${response.body}',
      );
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

  Future<NewsResponseModel> searchNews({
    required String query,
    int page = 1,
    int pageSize = 30,
    String? sortBy,
  }) async {
    try {
      final Map<String, String> queryParams = {
        'apiKey': _apiKey,
        'q': query,
        'page': page.toString(),
        'pageSize': pageSize.toString(),
      };

      if (sortBy != null && sortBy.isNotEmpty) {
        queryParams['sortBy'] = sortBy;
      }

      final url = Uri.parse(
        '$_baseUrl${Constants.everything}',
      ).replace(queryParameters: queryParams);

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return NewsResponseModel.fromMap(data);
      } else {
        throw Exception('gagal menampilkan berita');
      }
    } catch (e) {
      throw Exception('Terjadi kesalahan: $e');
    }
  }
}
