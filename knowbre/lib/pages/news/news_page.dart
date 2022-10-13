import 'package:flutter/material.dart';
import 'package:knowbre/shared/themes/app_colors.dart';
import 'package:knowbre/shared/widgets/cardNews_widget.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  final List news = [
    'Noticía 1',
    'Noticía 2',
    'Noticía 3',
    'Noticía 4',
  ];

  Widget _tilteNews() {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        height: 30,
        child: const Text(
          "Noticias",
          style: TextStyle(
            fontSize: 26,
            color: AppColor.primary,
            fontFamily: "Montserrat",
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      body: Column(
        children: [
          _tilteNews(),
          Expanded(
            child: ListView.separated(
                itemCount: news.length,
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(thickness: 1),
                itemBuilder: (context, index) {
                  return CardNews(
                    child: news[index],
                  );
                }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
