import 'package:flutter/material.dart';
import 'package:knowbre/shared/services/api_news.dart';
import 'package:knowbre/shared/themes/app_colors.dart';
import 'package:knowbre/shared/models/article.dart';
import 'package:knowbre/shared/services/api_news.dart';
import 'package:knowbre/shared/widgets/cardNews_widget.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  ApiService client = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      body: FutureBuilder(
        future: client.getArticle(),
        builder: (BuildContext context, AsyncSnapshot<List<Article>> snapshot) {
          if (snapshot.hasData) {
            List<Article>? articles = snapshot.data;
            return ListView.builder(
                itemCount: articles?.length,
                itemBuilder: (context, index) =>
                    customListTile(articles![index]));
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
