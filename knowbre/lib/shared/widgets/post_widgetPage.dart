import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:knowbre/pages/upload_post/post_page.dart';
import 'package:knowbre/shared/constants/controllers.dart';
import 'package:knowbre/shared/models/post.dart';
import 'package:knowbre/shared/models/user.dart';
import 'package:knowbre/shared/themes/app_colors.dart';

class PostWidgetPage extends StatefulWidget {
  final Post post;
  const PostWidgetPage({Key? key, required this.post}) : super(key: key);

  @override
  State<PostWidgetPage> createState() => _PostWidgetPageState();
}

class _PostWidgetPageState extends State<PostWidgetPage> {
  @override
  String currentUserId = authController.firebaseAuth.currentUser!.uid;

  Widget buildPostHeader() {
    return FutureBuilder<DocumentSnapshot>(
        future: firebaseFirestore
            .collection("users")
            .doc(widget.post.ownerId)
            .get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }
          UserModel user = UserModel.fromSnap(snapshot.data!);
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(user.photoURL ?? ''),
              backgroundColor: Colors.grey,
            ),
            title: GestureDetector(
              onTap: () {},
              child: Text(
                widget.post.title,
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
            subtitle: Text("Por ${widget.post.username}"),
          );
        });
  }

  buildPostImage() {
    return GestureDetector(
      onDoubleTap: () {},
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          CachedNetworkImage(
            imageUrl: widget.post.mediaUrl,
            fit: BoxFit.cover,
            height: 200,
            width: 300,
            placeholder: (context, url) => Padding(
              child: CircularProgressIndicator(),
              padding: EdgeInsets.all(20),
            ),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
        ],
      ),
    );
  }

  Widget buildPostDescription() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(left: 20, bottom: 20, top: 10, right: 20),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: AppColor.background,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 3.0,
                )
              ]),
          alignment: Alignment.centerLeft,
          child: Text(widget.post.description, textAlign: TextAlign.start),
        ),
      ],
    );
  }

  Widget build(BuildContext context) {
    return GestureDetector(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          buildPostHeader(),
          buildPostDescription(),
          buildPostImage(),
        ],
      ),
    );
  }
}
