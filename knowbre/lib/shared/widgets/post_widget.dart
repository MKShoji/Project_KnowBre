import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:knowbre/pages/profile/profile_page.dart';
import 'package:knowbre/pages/upload_post/post_page.dart';
import 'package:knowbre/shared/constants/controllers.dart';
import 'package:knowbre/shared/models/models.dart';
import 'package:knowbre/shared/models/post.dart';
import 'package:knowbre/shared/themes/app_colors.dart';

class PostWidget extends StatefulWidget {
  final Post post;
  const PostWidget({Key? key, required this.post}) : super(key: key);

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  @override
  String currentUserId = authController.firebaseAuth.currentUser!.uid;

  deletePost() async {
    firebaseFirestore
        .collection("posts")
        .doc(widget.post.ownerId)
        .collection("userPost")
        .doc(widget.post.postId)
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
        .child('post_${widget.post.postId}.jpg')
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
        future: firebaseFirestore
            .collection("users")
            .doc(widget.post.ownerId)
            .get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }
          UserModel user = UserModel.fromSnap(snapshot.data!);
          bool isPostOwner = authController.firebaseAuth.currentUser?.uid ==
              widget.post.ownerId;
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(user.photoURL ?? ''),
              backgroundColor: AppColor.primary,
            ),
            title: GestureDetector(
              onTap: () {
                Get.to(() => ProfilePage(profileId: widget.post.ownerId));
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
              imageUrl: widget.post.mediaUrl,
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
                widget.post.title,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            Text(widget.post.description),
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
          Get.to(() => PostPage(
                postId: widget.post.postId,
                userId: widget.post.ownerId,
              ));
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
