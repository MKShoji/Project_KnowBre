import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:knowbre/pages/news/news_page.dart';
import 'package:knowbre/pages/profile/profile_page.dart';
import 'package:knowbre/pages/upload_post/upload_post.dart';
import 'package:knowbre/shared/constants/controllers.dart';
import 'package:knowbre/shared/services/auth_controller.dart';
import 'package:knowbre/shared/themes/app_colors.dart';

import '../search/search_page.dart';
import 'home_page.dart';

class HomePageController extends StatefulWidget {
  const HomePageController({Key? key}) : super(key: key);

  @override
  State<HomePageController> createState() => _HomePageControllerState();
}

class _HomePageControllerState extends State<HomePageController> {
  int currentTab = 0;

  final List<Widget> screens = [
    HomePage(),
    const SearchPage(),
    const UploadPostPage(),
    const NewsPage(),
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = (HomePage());

  Future<void> siginOut() async {
    await AuthController().signOut();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
        future: firebaseFirestore
            .collection('users')
            .doc(authController.firebaseAuth.currentUser!.uid)
            .get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Scaffold(
              backgroundColor: AppColor.background,
              body: Center(
                child: CircularProgressIndicator(color: AppColor.primary),
              ),
            );
          }
          return Scaffold(
            resizeToAvoidBottomInset: false,
            drawer: Drawer(
              child: ListView(children: [
                UserAccountsDrawerHeader(
                  currentAccountPicture: CircleAvatar(
                    backgroundImage: NetworkImage(authController
                            .firestoreUser.value?.photoURL ??
                        "https://www.zohowebstatic.com/sites/default/files/show/avatar_image.png"),
                  ),
                  accountName: Text(
                    authController.firestoreUser.value?.username ??
                        "Nome Usuário",
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Montserrat',
                      color: AppColor.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  accountEmail: Text(
                    authController.user?.email ?? "email",
                    style: TextStyle(
                      fontSize: 10,
                      fontFamily: 'Montserrat',
                      color: AppColor.profilePickIcon,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  decoration: BoxDecoration(color: AppColor.background),
                ),
                ListTile(
                  dense: true,
                  title: Text(
                    'Profile',
                    style: TextStyle(color: AppColor.primary),
                  ),
                  trailing: Icon(Icons.person, color: AppColor.primary),
                  onTap: () {
                    Get.to(
                      () => ProfilePage(
                        profileId: authController.firebaseAuth.currentUser!.uid,
                      ),
                      transition: Transition.cupertino,
                    );
                  },
                ),
                ListTile(
                  title: Text(
                    'Home',
                  ),
                  onTap: () {
                    setState(() {
                      currentScreen = HomePage();
                      currentTab = 0;
                    });
                  },
                  trailing: Icon(
                    Icons.home,
                  ),
                ),
                ListTile(
                  title: Text(
                    'InfoBre',
                  ),
                  onTap: () {
                    setState(() {
                      currentScreen = const NewsPage();
                      currentTab = 3;
                    });
                  },
                  trailing: Icon(
                    Icons.newspaper,
                  ),
                ),
                ListTile(
                  title: Text('Sair'),
                  trailing: Icon(Icons.exit_to_app_outlined),
                  onTap: () {
                    AuthController().signOut();
                    Get.snackbar(
                      "LogOut",
                      "Você foi desconectado",
                      icon: Icon(Icons.check_circle_outline,
                          color: AppColor.primary),
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: AppColor.snackBarBackground,
                      colorText: AppColor.background,
                    );
                  },
                ),
              ]),
            ),
            appBar: AppBar(
              title: const Text(
                "Knowbre",
                style: TextStyle(
                  color: AppColor.primary,
                  fontSize: 18,
                ),
              ),
              centerTitle: true,
              backgroundColor: AppColor.background,
              iconTheme: IconThemeData(color: AppColor.primary),
              toolbarHeight: 40,
              shadowColor: AppColor.background,
              elevation: 1,
              actions: [
                GestureDetector(
                  onTap: () {
                    Get.to(
                      () => ProfilePage(
                        profileId: authController.firebaseAuth.currentUser!.uid,
                      ),
                      transition: Transition.cupertino,
                    );
                  },
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(authController
                            .firestoreUser.value?.photoURL ??
                        'https://www.zohowebstatic.com/sites/default/files/show/avatar_image.png'),
                    radius: 15,
                  ),
                ),
              ],
            ),
            body: PageStorage(
              bucket: bucket,
              child: currentScreen,
            ),
            floatingActionButton: FloatingActionButton(
              child: Container(
                child: Icon(
                  Icons.visibility_outlined,
                  size: 30,
                  color: AppColor.background,
                ),
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [AppColor.primary, AppColor.primaryg],
                    begin: Alignment.topCenter,
                  ),
                ),
              ),
              onPressed: () {},
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: BottomAppBar(
              shape: const CircularNotchedRectangle(),
              notchMargin: 10,
              child: Container(
                height: 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    // Icones da esquerda
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MaterialButton(
                          minWidth: 40,
                          onPressed: () {
                            setState(() {
                              currentScreen = HomePage();
                              currentTab = 0;
                            });
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.import_contacts_sharp,
                                color: currentTab == 0
                                    ? AppColor.primary
                                    : Colors.grey,
                              ),
                            ],
                          ),
                        ),
                        MaterialButton(
                          minWidth: 40,
                          onPressed: () {
                            setState(() {
                              currentScreen = SearchPage();
                              currentTab = 1;
                            });
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.search,
                                color: currentTab == 1
                                    ? AppColor.primary
                                    : Colors.grey,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    // Icones da direita
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MaterialButton(
                          minWidth: 40,
                          onPressed: () {
                            setState(() {
                              currentScreen = const NewsPage();
                              currentTab = 3;
                            });
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.newspaper,
                                color: currentTab == 3
                                    ? AppColor.primary
                                    : Colors.grey,
                              ),
                            ],
                          ),
                        ),
                        MaterialButton(
                          minWidth: 40,
                          onPressed: () {
                            Get.to(() => UploadPostPage(),
                                transition: Transition.cupertino);
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add,
                                color: currentTab == 4
                                    ? AppColor.primary
                                    : Colors.grey,
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
