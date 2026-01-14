import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/controllers/news_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    NewsController controller = Get.put<NewsController>(NewsController());

    return Scaffold(
      appBar: AppBar(title: Text('Home Page')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Home page'),
            Expanded(
              child: Obx(() {
                log('data yang ada sebanyak: ${controller.articles.length}');
                if (controller.isLoading) {
                  return CircularProgressIndicator();
                }
                log('data yang ada sebanyak: ${controller.articles.length}');
                return ListView.builder(
                  itemCount: controller.articles.length,
                  itemBuilder: (context, index) {
                    final article = controller.articles[index];
                    log('message: ${article.title}');
                    return ListTile(
                      title: Text(article.title ?? '-'),
                      subtitle: Text(article.description ?? 'No Description'),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
