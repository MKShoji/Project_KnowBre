import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:knowbre/pages/profile/profile_edit_page.dart';
import 'package:knowbre/shared/constants/controllers.dart';
import 'package:knowbre/shared/themes/app_colors.dart';

class ProfileHeaderWidget extends StatefulWidget {
  final String profileId;
  final int postCount;

  ProfileHeaderWidget(this.profileId, this.postCount);

  @override
  State<ProfileHeaderWidget> createState() => _ProfileHeaderWidgetState();
}

class _ProfileHeaderWidgetState extends State<ProfileHeaderWidget> {
  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
        floating: false,
        pinned: true,
        delegate: HeaderDelegate(widget.profileId, widget.postCount));
  }
}

class HeaderDelegate extends SliverPersistentHeaderDelegate {
  final String profileId;
  final int postCount;

  HeaderDelegate(this.profileId, this.postCount);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return FutureBuilder(
        future: firebaseFirestore.collection('users').doc(profileId).get(),
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
  double get maxExtent => 250;

  @override
  double get minExtent => 210;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
