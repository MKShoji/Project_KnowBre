import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:knowbre/shared/constants/controllers.dart';

import 'package:knowbre/shared/services/auth_controller.dart';
import 'package:knowbre/shared/themes/app_colors.dart';
import 'package:knowbre/shared/widgets/cardPreview_widget.dart';

import '../../shared/models/post.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<Post>> _getData() async {
    List<Post> postList = [];
    DatabaseReference postRef = firebaseDatabase.child("Blogs");
    await postRef.once().then((snap) {
      postList.clear();
      var map = Map<String, dynamic>.from(
          snap.snapshot.value as Map<dynamic, dynamic>);

      map.forEach((key, value) {
        var values = Map<String, dynamic>.from(map);
        Post posts = Post(
            titulo: values['title'],
            descricao: values['desc'],
            imagem: values['image'],
            numArtigos: values['numArt']);
        postList.add(posts);
      });
    });
    return postList = [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: FutureBuilder<List<Post>>(
            future: _getData(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return CardPreview(
                      data: snapshot.data![index],
                    );
                  },
                );
              }
              if (snapshot.hasError) {
                return Center(
                  child: Text('Sem posts por enquanto'),
                );
              }
              return Center(
                child: Container(
                  width: 50,
                  height: 50,
                  child: CircularProgressIndicator(),
                ),
              );
            }),
      ),
    );
  }
}
