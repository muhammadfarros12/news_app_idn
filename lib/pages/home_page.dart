import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/controllers/news_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    NewsController controller = NewsController();

    return Scaffold(
      appBar: AppBar(title: Text('Home Page')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('ini adalah halaman home page'),
            SizedBox(height: 50),

            FilledButton(
              onPressed: () {
                Get.toNamed('/detail');
              },
              child: Text('ke halaman detail'),
            ),
            SizedBox(height: 50),
            Obx(() {
              if (controller.isLoading.value) {
                return CircularProgressIndicator();
              }
              return Center(child: Text(controller.title.value));
            }),
            SizedBox(height: 50),

            FilledButton(
              onPressed: () {
                controller.fetchNews();
              },
              child: Text('munculkan data berita'),
            ),
          ],
        ),
      ),
    );
  }
}
