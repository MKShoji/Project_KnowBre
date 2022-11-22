import 'package:flutter/material.dart';
import 'package:knowbre/shared/models/post.dart';
import 'package:knowbre/shared/themes/app_colors.dart';
import 'package:knowbre/shared/utilities/cache_image.dart';

class CardPostWidget extends StatelessWidget {
  final Post post;
  const CardPostWidget({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        child: Stack(children: <Widget>[
          cachedNetworkImage(post.mediaUrl),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  post.title,
                  style: TextStyle(
                    color: AppColor.background,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat',
                  ),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
