import 'package:flutter/material.dart';
import 'package:news_app/pages/detail_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
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
                Navigator.of(
                  context,
                ).push(MaterialPageRoute(builder: (context) => DetailPage()));
              },
              child: Text('ke halaman detail'),
            ),
          ],
        ),
      ),
    );
  }
}
