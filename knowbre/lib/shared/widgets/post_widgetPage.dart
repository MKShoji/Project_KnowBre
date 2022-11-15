import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:knowbre/pages/upload_post/post_page.dart';
import 'package:knowbre/shared/constants/controllers.dart';
import 'package:knowbre/shared/models/post.dart';

class PostWidgetPage extends StatefulWidget {
  final Post? post;
  const PostWidgetPage({Key? key, this.post}) : super(key: key);

  @override
  State<PostWidgetPage> createState() => _PostWidgetPageState();
}

class _PostWidgetPageState extends State<PostWidgetPage> {
  @override
  String currentUserId = authController.firebaseAuth.currentUser!.uid;

  Widget buildPostHeader() {
    return FutureBuilder(
        future: firebaseFirestore
            .collection("posts")
            .doc(widget.post!.ownerId)
            .get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                  authController.firestoreUser.value?.photoURL ?? ''),
              backgroundColor: Colors.grey,
            ),
            title: GestureDetector(
              onTap: () {},
              child: Text(
                authController.firestoreUser.value?.username ?? 'Usuário',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
            subtitle: Text(widget.post!.title),
            trailing: IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
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
            imageUrl: widget.post!.mediaUrl,
            fit: BoxFit.cover,
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

  Widget buildPostFooter() {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 40.0, left: 20.0),
            ),
            GestureDetector(
              onTap: () {},
              child:
                  Icon(Icons.favorite_border, size: 28.0, color: Colors.pink),
            ),
            Padding(
              padding: EdgeInsets.only(right: 20.0),
            ),
            GestureDetector(
              onTap: () {},
              child:
                  Icon(Icons.star_border, size: 28.0, color: Colors.blue[900]),
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.start,
        ),
        Row(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 20.0),
              child: Text(
                'likes',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 20.0),
              child: Text(
                '${authController.firestoreUser.value!.username} ',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: Text(widget.post!.description),
            )
          ],
        )
      ],
    );
  }

  Widget build(BuildContext context) {
    return GestureDetector(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          buildPostHeader(),
          buildPostImage(),
          buildPostFooter()
        ],
      ),
    );
  }
}
