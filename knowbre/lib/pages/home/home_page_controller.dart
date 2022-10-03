import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:knowbre/pages/cursos/cursos_page.dart';
import 'package:knowbre/pages/favoritos/favoritos_page.dart';
import 'package:knowbre/pages/profile/profile_page.dart';
import 'package:knowbre/shared/constants/controllers.dart';
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
    const FavoritosPage(),
    const CursosPage(),
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = (HomePage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(authController
                      .firestoreUser.value?.photoURL ??
                  "https://www.zohowebstatic.com/sites/default/files/show/avatar_image.png"),
            ),
            accountName:
                Text(authController.firestoreUser.value?.nome ?? "Nome"),
            accountEmail: Text(authController.user?.email ?? "email"),
          ),
          ListTile(
            dense: true,
            title: Text('Profile'),
            selected: true,
            trailing: Icon(Icons.person),
            onTap: () {
              Get.to(
                () => ProfilePage(),
                transition: Transition.cupertino,
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
        backgroundColor: AppColor.background,
        iconTheme: IconThemeData(color: AppColor.primary),
        toolbarHeight: 40,
        shadowColor: AppColor.background,
        elevation: 1,
      ),
      body: PageStorage(
        bucket: bucket,
        child: currentScreen,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
                          Icons.home,
                          color: currentTab == 0 ? Colors.blue : Colors.grey,
                        ),
                        Text(
                          'Home',
                          style: TextStyle(
                            color: currentTab == 0 ? Colors.blue : Colors.grey,
                          ),
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
                          color: currentTab == 1 ? Colors.blue : Colors.grey,
                        ),
                        Text(
                          'Search',
                          style: TextStyle(
                            color: currentTab == 1 ? Colors.blue : Colors.grey,
                          ),
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
                        currentScreen = const CursosPage();
                        currentTab = 3;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.school,
                          color: currentTab == 3 ? Colors.blue : Colors.grey,
                        ),
                        Text(
                          'Cursos',
                          style: TextStyle(
                            color: currentTab == 3 ? Colors.blue : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = const FavoritosPage();
                        currentTab = 4;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.star,
                          color: currentTab == 4 ? Colors.blue : Colors.grey,
                        ),
                        Text(
                          'Favoritos',
                          style: TextStyle(
                            color: currentTab == 4 ? Colors.blue : Colors.grey,
                          ),
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
  }
}
