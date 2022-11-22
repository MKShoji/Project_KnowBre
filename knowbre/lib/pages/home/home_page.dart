import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:knowbre/shared/constants/controllers.dart';
import 'package:knowbre/shared/widgets/post_widget.dart';

import '../../shared/models/post.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  bool isLoading = false;
  int postCount = 0;
  List<Post> posts = [];

  void initState() {
    super.initState();
    getPost();
  }

  getPost() async {
    setState(() {
      isLoading = true;
    });
    // QuerySnapshot snapshot = await firebaseFirestore
    //     .collection("posts")
    //     .doc(authController.firebaseAuth.currentUser?.uid)
    //     .collection('userPost')
    //     .orderBy('timestamp', descending: true)
    //     .get();
    QuerySnapshot snapshot =
        await firebaseFirestore.collectionGroup("userPost").get();
    setState(() {
      isLoading = false;
      postCount = snapshot.docs.length;
      posts = snapshot.docs.map((doc) => Post.fromDocument(doc)).toList();
    });
  }

  buildPost() {
    if (isLoading) {
      return CircularProgressIndicator();
    } else if (posts.isEmpty) {
      return Center(
        child: Text("Sem Posts"),
      );
    }
    List<PostWidget> postW = [];
    posts.forEach((post) {
      postW.add(PostWidget(post: post));
    });
    return Column(
      children: postW,
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: buildPost(),
      ),
    );
  }
}
