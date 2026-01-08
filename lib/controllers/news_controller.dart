import 'package:get/state_manager.dart';

class NewsController extends GetxController {
  var title = 'Judul berita kemarin'.obs;

  void updateBerita() {
    title.value = 'Berita terbaru hari ini';
  }
}
