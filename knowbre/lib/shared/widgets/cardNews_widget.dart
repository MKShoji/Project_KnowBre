import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:knowbre/shared/models/article.dart';
import 'package:knowbre/shared/themes/app_colors.dart';
import 'package:url_launcher/link.dart';

Widget customListTile(Article article) {
  return InkWell(
    onTap: () {
      Get.bottomSheet(
        Container(
          height: 450,
          child: SingleChildScrollView(
            child: Column(
              children: [
                article.urlToImage != null
                    ? Container(
                        height: 150.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(article.urlToImage ?? ''),
                              fit: BoxFit.cover),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      )
                    : Container(
                        height: 150.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                  'https://source.unsplash.com/weekly?coding'),
                              fit: BoxFit.cover),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                SizedBox(
                  height: 8.0,
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(6.0),
                      margin: EdgeInsets.only(right: 5.0),
                      decoration: BoxDecoration(
                        color: AppColor.primary,
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: Text(
                        article.source.name,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.verified_rounded,
                      color: AppColor.primary,
                      size: 30.0,
                    ),
                  ],
                ),
                SizedBox(height: 8.0),
                Text(
                  article.description ?? '',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14.0,
                  ),
                ),
                SizedBox(height: 20.0),
                Link(
                  uri: Uri.parse(article.url),
                  target: LinkTarget.blank,
                  builder: (contex, FollowLink) => GestureDetector(
                    onTap: FollowLink,
                    child: Text(
                      'Acessar fonte',
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.blue,
                          decoration: TextDecoration.underline),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        backgroundColor: AppColor.background,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        isScrollControlled: true,
        ignoreSafeArea: false,
        enableDrag: true,
      );
    },
    child: Container(
      margin: EdgeInsets.all(12.0),
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 3.0,
            ),
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200.0,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(article.urlToImage ??
                      'https://melabiss.com/web/image/product.product/2483/image_1024'),
                  fit: BoxFit.cover),
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
          SizedBox(height: 8.0),
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(10.0),
                margin: EdgeInsets.only(right: 5.0),
                decoration: BoxDecoration(
                  color: AppColor.primary,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Text(
                  article.source.name,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              Icon(
                  Icons.verified_rounded,
                  color: AppColor.primary,
                  size: 30.0,
                ),
            ],
          ),
          SizedBox(height: 8.0),
          Column(
            children: [
              Text(
                article.title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
              SizedBox(height: 8.0),
              Row(
                children: [
                  Text("Autor(a): ",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(article.author ?? 'Desconhecido')
                ],
              )
            ],
          )
        ],
      ),
    ),
  );
}
