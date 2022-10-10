import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:knowbre/pages/profile/profile_contoller.dart';
import 'package:knowbre/pages/profile/profile_edit_page.dart';
import 'package:knowbre/shared/constants/controllers.dart';
import 'package:knowbre/shared/themes/app_colors.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ProfileController _profileControllerx = Get.put(ProfileController());

  Widget _header() {
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
                      authController.firestoreUser.value?.nome ??
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
                      '@usuario',
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
                            text: authController.firestoreUser.value?.formacao,
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
                                authController.firestoreUser.value?.localizacao,
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
                            text: " Autor de x cards",
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
          Container(
            width: double.maxFinite,
            height: 200,
            child: TabBarView(
              children: [
                Center(child: Text("Meus Cards")),
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
