import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:knowbre/pages/upload_post/post_page.dart';
import 'package:knowbre/shared/constants/controllers.dart';
import 'package:knowbre/shared/models/post.dart';

class PostWidget extends StatefulWidget {
  final Post post;
  const PostWidget({Key? key, required this.post}) : super(key: key);

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  @override
  String currentUserId = authController.firebaseAuth.currentUser!.uid;
  int likeCount = 0;
  bool isLiked = false;
  Map likes = {};

  void initState() {
    super.initState();
    likeCount = widget.post.getLikeCount(widget.post.likes);
    likes = widget.post.likes;
    isLiked = (likes[authController.firebaseAuth.currentUser?.uid]);
  }

  handleLikePost() {
    bool _isLiked = likes[currentUserId] == true;
    if (_isLiked) {
      firebaseFirestore
          .collection("posts")
          .doc(widget.post.ownerId)
          .collection('userPosts')
          .doc(widget.post.postId)
          .update({'likes.$currentUserId': false});
      setState(() {
        likeCount -= 1;
        isLiked = false;
        likes[currentUserId] = false;
      });
    } else if (isLiked != null) {
      firebaseFirestore
          .collection("posts")
          .doc(widget.post.ownerId)
          .collection('userPosts')
          .doc(widget.post.postId)
          .update({
        'likes.$currentUserId': true,
      });
      setState(() {
        likeCount += 1;
        isLiked = true;
        likes[currentUserId] = true;
      });
    }
  }

  Widget buildPostHeader() {
    return FutureBuilder(
        future: firebaseFirestore
            .collection("posts")
            .doc(widget.post.ownerId)
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
            subtitle: Text(widget.post.title),
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
            imageUrl: widget.post.mediaUrl,
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
              onTap: handleLikePost,
              child: Icon(isLiked ? Icons.favorite : Icons.favorite_border,
                  size: 28.0, color: Colors.pink),
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
              child: Text(widget.post.description),
            )
          ],
        )
      ],
    );
  }

  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => PostPage());
      },
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
