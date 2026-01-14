import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/models/news_response_model.dart';

class DetailPage extends StatelessWidget {
  final Article article = Get.arguments;
  DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detail Page')),
      body: Center(child: Text(article.title!)),
    );
  }
}
