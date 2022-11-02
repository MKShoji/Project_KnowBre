import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:knowbre/shared/constants/controllers.dart';
import 'package:knowbre/shared/utilities/cache_image.dart';

class Post extends StatefulWidget {
  final String postId;
  final String ownerId;
  final String? username;
  final String title;
  final String description;
  final String mediaUrl;
  final dynamic likes;

  Post(
      {required this.postId,
      required this.ownerId,
      required this.username,
      required this.title,
      required this.description,
      required this.mediaUrl,
      this.likes});

  factory Post.fromDocument(DocumentSnapshot doc) {
    return Post(
      postId: doc['postId'],
      ownerId: doc['ownerId'],
      username: doc['username'],
      title: doc['title'],
      description: doc['description'],
      mediaUrl: doc['mediaUrl'],
      likes: doc['likes'],
    );
  }

  int getLikeCount(likes) {
    if (likes == {}) {
      return 0;
    }

    int count = 0;
    likes.values.forEach((val) {
      if (val == true) {
        count += 1;
      }
    });
    return count;
  }

  @override
  State<Post> createState() => _PostState(
      description: this.description,
      likeCount: getLikeCount(this.likes),
      likes: this.likes,
      mediaUrl: this.mediaUrl,
      ownerId: this.ownerId,
      postId: this.postId,
      title: this.title,
      username: this.title);
}

class _PostState extends State<Post> {
  final String postId;
  final String ownerId;
  final String username;
  final String title;
  final String description;
  final String mediaUrl;
  int likeCount;
  Map likes;

  _PostState({
    required this.postId,
    required this.ownerId,
    required this.username,
    required this.title,
    required this.description,
    required this.mediaUrl,
    required this.likes,
    required this.likeCount,
  });

  Widget buildPostHeader() {
    return FutureBuilder(
        future: firebaseFirestore.collection("posts").doc(ownerId).get(),
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
            subtitle: Text(title),
            trailing: IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
          );
        });
  }

  Widget buildPostImage() {
    return GestureDetector(
      onDoubleTap: () {},
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Align(
              alignment: Alignment.centerLeft,
              child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  height: 200,
                  width: 200,
                  child: cachedNetworkImage(mediaUrl))),
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
                '$likeCount likes',
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
              child: Text(description),
            )
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        buildPostHeader(),
        buildPostImage(),
        buildPostFooter(),
      ],
    );
  }
}
