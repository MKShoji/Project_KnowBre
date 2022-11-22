import 'package:flutter/material.dart';
import 'package:knowbre/shared/themes/app_colors.dart';

class CardArticles extends StatelessWidget {
  final int index;
  const CardArticles({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tituloArticleController = TextEditingController();
    final textArticleController = TextEditingController();

    return Container(
      decoration: BoxDecoration(
          color: AppColor.background,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0.0, 1.0), //(x,y)
              blurRadius: 6.0,
            )
          ]),
      margin: EdgeInsets.symmetric(vertical: 30, horizontal: 5),
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15),
              child: TextFormField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: "Título do Artigo",
                  hintStyle:
                      TextStyle(color: AppColor.profilePick, fontSize: 22),
                  border: InputBorder.none,
                ),
                controller: tituloArticleController,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: TextFormField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                maxLength: 300,
                decoration: InputDecoration(
                  hintText: "Corpo do artigo...",
                  hintStyle:
                      TextStyle(color: AppColor.profilePickIcon, fontSize: 12),
                  border: InputBorder.none,
                ),
                controller: textArticleController,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
