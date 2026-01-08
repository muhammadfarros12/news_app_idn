import 'dart:convert';

import 'package:get/state_manager.dart';
import 'package:http/http.dart' as http;

class NewsController extends GetxController {
  var title = 'Judul berita kemarin'.obs;
  var isLoading = false.obs;

  Future fetchNews() async {
    isLoading.value = true;

    final url = Uri.parse(
      'https://newsapi.org/v2/top-headlines?country=us&apiKey=f9f29e59ba954bc9850585d2a07fb479',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      title.value = data['articles'][10]['title'];
    } else {
      title.value = 'Failed to load news';
    }

    isLoading.value = false;
  }
}
