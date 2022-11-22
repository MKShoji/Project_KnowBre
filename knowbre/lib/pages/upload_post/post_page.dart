import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:knowbre/shared/constants/controllers.dart';
import 'package:knowbre/shared/models/post.dart';
import 'package:knowbre/shared/models/user.dart';
import 'package:knowbre/shared/themes/app_colors.dart';
import 'package:knowbre/shared/widgets/cardArticles_widget.dart';
import 'package:knowbre/shared/widgets/htmlWidget.dart';
import 'package:knowbre/shared/widgets/post_widgetPage.dart';

class PostPage extends StatefulWidget {
  final String? userId;
  final String? postId;
  const PostPage({Key? key, this.userId, this.postId}) : super(key: key);

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
        future: firebaseFirestore
            .collection('posts')
            .doc(widget.userId)
            .collection('userPost')
            .doc(widget.postId)
            .get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else {
            Post post = Post.fromDocument(snapshot.data!);
            return Center(
              child: Scaffold(
                appBar: AppBar(
                  backgroundColor: AppColor.background,
                  iconTheme: IconThemeData(color: AppColor.primary),
                  toolbarHeight: 40,
                  shadowColor: AppColor.background,
                  elevation: 1,
                ),
                body: ListView(
                  children: <Widget>[
                    Container(
                      child: PostWidgetPage(
                        post: post,
                      ),
                    ),
                    SizedBox(height: 30),
                    HtmlPageWidget(post: post),
                  ],
                ),
                bottomNavigationBar: BottomAppBar(
                  color: AppColor.background,
                  elevation: 3,
                  child: IconTheme(
                    data: IconThemeData(
                      color: AppColor.primary,
                    ),
                    child: Row(
                      children: <Widget>[
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.bookmark_add_outlined,
                            size: 28.0,
                          ),
                        ),
                        IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.star_border,
                              size: 28.0,
                            ))
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
        });
  }
}
