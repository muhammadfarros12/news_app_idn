import 'package:get/state_manager.dart';
import 'package:news_app/services/news_service.dart';

class NewsController extends GetxController {
  final NewsService service = NewsService();

  var title = 'Judul berita kemarin'.obs;
  var isLoading = false.obs;

  Future fetchNews() async {

    try {
    isLoading.value = true;
    title.value = await service.getTopHeadlines();
    } catch (e) {
     title.value = 'Gagal mengambil berita karena $e'; 
    } finally {
    isLoading.value = false;
    }

  }
}
