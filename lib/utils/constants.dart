import 'package:flutter_dotenv/flutter_dotenv.dart';

class Constants {
  static const String baseUrl = 'https://newsapi.org/v2';

  static String get apiKey => dotenv.env['NEWS_API_KEY'] ?? '';

  // endpoints
  static const String topHeadlines = '/top-headlines';
  static const String everything = '/everything';

  // categories
  static const List<String> categories = [
    'general',
    'business',
    'entertainment',
    'health',
    'science',
    'sports',
    'technology'
  ];

  static const String country = 'us';

  static const String nameApp = 'News App';

}