import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:knowbre/pages/profile/profile_contoller.dart';
import 'package:knowbre/pages/profile/profile_edit_page.dart';
import 'package:knowbre/shared/constants/controllers.dart';
import 'package:knowbre/shared/models/post.dart';
import 'package:knowbre/shared/themes/app_colors.dart';
import 'package:knowbre/shared/widgets/cardPost_widget.dart';
import 'package:knowbre/shared/widgets/post_widget.dart';

class ProfilePage extends StatefulWidget {
  final String profileId;
  const ProfilePage({Key? key, required this.profileId}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ProfileController _profileControllerx = Get.put(ProfileController());

  final String? currentUserId = authController.firebaseAuth.currentUser?.uid;
  bool isLoading = false;
  int postCount = 0;
  List<Post> posts = [];
  String postOrientation = "grid";
  bool isFollowing = false;
  int followerCount = 0;
  int followingCount = 0;

  void initState() {
    super.initState();
    getProfilePosts();
  }

  getProfilePosts() async {
    setState(() {
      isLoading = true;
    });
    QuerySnapshot snapshot = await firebaseFirestore
        .collection("posts")
        .doc(widget.profileId)
        .collection('userPost')
        .orderBy('timestamp', descending: true)
        .get();
    setState(() {
      isLoading = false;
      postCount = snapshot.docs.length;
      posts = snapshot.docs.map((doc) => Post.fromDocument(doc)).toList();
    });
  }

  Widget buildProfilePosts() {
    if (isLoading) {
      return CircularProgressIndicator();
    }
    List<GridTile> gridTiles = [];
    posts.forEach((post) {
      gridTiles.add(GridTile(
        child: CardPostWidget(post: post),
      ));
    });
    return GridView.count(
      crossAxisCount: 3,
      childAspectRatio: 0.60,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: gridTiles,
    );
  }

  Widget _header() {
    return FutureBuilder(
        future:
            firebaseFirestore.collection('users').doc(widget.profileId).get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }
          return Container(
            width: double.infinity,
            height: 210,
            color: AppColor.background,
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Column(
              children: <Widget>[
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                        authController.firestoreUser.value?.photoURL ??
                            "https://www.zohowebstatic.com/sites/default/files/show/avatar_image.png",
                      ),
                      radius: 40,
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: SizedBox(
                          height: 30,
                          width: 100,
                          child: TextButton(
                            style: TextButton.styleFrom(
                              textStyle: TextStyle(
                                fontSize: 11,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                              ),
                              backgroundColor: AppColor.primary,
                              primary: AppColor.background,
                            ),
                            onPressed: () {
                              Get.to(() => ProfileEditPage(),
                                  transition: Transition.cupertino);
                            },
                            child: const Text(
                              "Editar perfil",
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            authController.firestoreUser.value?.username ??
                                'Nome completo',
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: AppColor.primary),
                          ),
                        ),
                      ),
                      Container(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '@${authController.firestoreUser.value?.username}',
                            style: TextStyle(
                              fontSize: 10,
                              fontFamily: 'Montserrat',
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: RichText(
                            text: TextSpan(
                              children: [
                                WidgetSpan(
                                  child: Icon(
                                    Icons.school_outlined,
                                    color: AppColor.primary,
                                    size: 20.0,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      ' ${authController.firestoreUser.value?.formacao}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'Montserrat',
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: RichText(
                            text: TextSpan(
                              children: [
                                WidgetSpan(
                                  child: Icon(
                                    Icons.location_on_outlined,
                                    color: AppColor.primary,
                                    size: 20.0,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      ' ${authController.firestoreUser.value?.localizacao}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'Montserrat',
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: RichText(
                            text: TextSpan(
                              children: [
                                WidgetSpan(
                                  child: Icon(
                                    Icons.edit_outlined,
                                    color: AppColor.primary,
                                    size: 20.0,
                                  ),
                                ),
                                TextSpan(
                                  text: 'Artigos: $postCount',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'Montserrat',
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        backgroundColor: AppColor.background,
        iconTheme: IconThemeData(color: AppColor.primary),
        toolbarHeight: 40,
        shadowColor: AppColor.background,
        elevation: 1,
      ),
      body: Column(
        children: <Widget>[
          _header(),
          Container(
            child: TabBar(
              tabs: _profileControllerx.tabs,
              controller: _profileControllerx.tabController,
              isScrollable: true,
              labelColor: AppColor.primary,
              unselectedLabelColor: Colors.black,
              indicatorColor: AppColor.primary,
            ),
          ),
          Expanded(
            child: TabBarView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(child: buildProfilePosts()),
                ),
                Center(child: Text("Meus videos")),
                Center(child: Text("Salves")),
              ],
              controller: _profileControllerx.tabController,
            ),
          ),
        ],
      ),
    );
  }
}
