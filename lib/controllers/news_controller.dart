import 'dart:developer';

import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:news_app/models/news_response_model.dart';
import 'package:news_app/services/news_service.dart';

class NewsController extends GetxController {
  final NewsService service = NewsService();

  final _isLoading = false.obs;
  final _articles = <Article>[].obs;
  final _error = ''.obs;

  // getter
  bool get isLoading => _isLoading.value;
  List<Article> get articles => _articles.toList();
  String get error => _error.value;

  @override
  void onInit() {
    super.onInit();
    fetchNews();
  }

  Future<void> fetchNews() async {
    try {
      _isLoading.value = true;
      _error.value = '';

      final response = await service.getTopHeadlines();

      _articles.value = response.articles ?? [];
      log('API returned: ${response.articles?.length}');
    } catch (e) {
      log('error: ${e.toString()}');
      _error.value = e.toString();

      Get.snackbar(
        'Error',
        'Failed to load news: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      _isLoading.value = false;
    }
  }

  Future<void> refreshNews() async {
    await fetchNews();
  }
}
