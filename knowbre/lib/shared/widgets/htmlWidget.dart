import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:knowbre/shared/constants/controllers.dart';
import 'package:knowbre/shared/models/post.dart';

class HtmlPageWidget extends StatefulWidget {
  final Post post;
  const HtmlPageWidget({Key? key, required this.post}) : super(key: key);

  @override
  State<HtmlPageWidget> createState() => _HtmlPageWidgetState();
}

class _HtmlPageWidgetState extends State<HtmlPageWidget> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: firebaseFirestore
          .collection("posts")
          .doc(widget.post.ownerId)
          .collection("userPost")
          .doc(widget.post.postId)
          .get(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        } else {
          Post post = Post.fromDocument(snapshot.data!);
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: HtmlWidget(post.text),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
