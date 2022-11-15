import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:knowbre/pages/profile/profile_page.dart';
import 'package:knowbre/pages/upload_post/post_page.dart';
import 'package:knowbre/shared/constants/controllers.dart';
import 'package:knowbre/shared/models/models.dart';
import 'package:knowbre/shared/themes/app_colors.dart';

class Post extends StatefulWidget {
  final String postId;
  final String ownerId;
  final String username;
  final String title;
  final String description;
  final String mediaUrl;
  final dynamic likes;

  Post({
    required this.postId,
    required this.ownerId,
    required this.username,
    required this.title,
    required this.description,
    required this.mediaUrl,
    this.likes,
  });

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
  final String? username;
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

  String currentUserId = authController.firebaseAuth.currentUser!.uid;

  deletePost() async {
    firebaseFirestore
        .collection("posts")
        .doc(ownerId)
        .collection("userPost")
        .doc(postId)
        .get()
        .then((doc) {
      if (doc.exists) {
        doc.reference.delete().then((value) => Get.defaultDialog(
              title: "Sucesso !",
              middleText: "Seus Post foi deletado com sucesso",
              backgroundColor: AppColor.backgroundList,
              titleStyle: TextStyle(color: AppColor.primary),
              radius: 30,
            ));
      }
    });

    firebaseStorage
        .ref()
        .child("/fotos")
        .child("posts")
        .child('post_${postId}.jpg')
        .delete();
  }

  handleDeletePost(BuildContext parentContext) {
    return showDialog(
      context: parentContext,
      builder: (context) => SimpleDialog(
        title: Text("Remover este post ?"),
        children: <Widget>[
          SimpleDialogOption(
            onPressed: () {
              Navigator.pop(context);
              deletePost();
            },
            child: Text(
              'Deletar',
              style: TextStyle(color: Colors.red),
            ),
          ),
          SimpleDialogOption(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancelar'),
          )
        ],
      ),
    );
  }

  Widget buildPostHeader() {
    return FutureBuilder<DocumentSnapshot>(
        future: firebaseFirestore.collection("users").doc(ownerId).get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }
          UserModel user = UserModel.fromSnap(snapshot.data!);
          bool isPostOwner =
              authController.firebaseAuth.currentUser?.uid == ownerId;
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(user.photoURL ?? ''),
              backgroundColor: AppColor.primary,
            ),
            title: GestureDetector(
              onTap: () {
                Get.to(() => ProfilePage(profileId: widget.ownerId));
              },
              child: Text(
                user.username ?? 'Usuário',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
            trailing: isPostOwner
                ? IconButton(
                    onPressed: () => handleDeletePost(context),
                    icon: Icon(Icons.more_vert),
                  )
                : Text(''),
          );
        });
  }

  buildPostImage() {
    return Container(
      margin: const EdgeInsets.only(right: 30),
      height: 125,
      width: 100,
      child: GestureDetector(
        onDoubleTap: () {},
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            CachedNetworkImage(
              imageUrl: mediaUrl,
              fit: BoxFit.cover,
              placeholder: (context, url) => Padding(
                child: CircularProgressIndicator(),
                padding: EdgeInsets.all(20),
              ),
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPostDescription() {
    return Expanded(
      child: Container(
        width: 100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            Text(description),
            SizedBox(
              height: 10,
            ),
            Text(
              "X ARTIGOS",
              style: TextStyle(
                  color: AppColor.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 14),
            )
          ],
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return Container(
      color: AppColor.backgroundList,
      child: GestureDetector(
        onTap: () {
          Get.to(() => PostPage());
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            buildPostHeader(),
            Container(
              color: AppColor.background,
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                textDirection: TextDirection.ltr,
                children: [buildPostImage(), buildPostDescription()],
              ),
            ),
            SizedBox(height: 50)
          ],
        ),
      ),
    );
  }
}
