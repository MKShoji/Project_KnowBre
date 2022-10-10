import 'package:flutter/material.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Text(
          "Notícias (InforBre)",
          style: TextStyle(fontSize: 30, color: Colors.white),
        ),
      ),
    );
  }
}
