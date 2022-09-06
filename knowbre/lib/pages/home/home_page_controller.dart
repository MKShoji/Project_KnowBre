import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:knowbre/pages/cursos/cursos_page.dart';
import 'package:knowbre/pages/favoritos/favoritos_page.dart';
import 'package:knowbre/shared/models/user.dart';
import 'package:knowbre/shared/services/auth_controller.dart';
import 'package:knowbre/shared/services/auth_services.dart';
import 'package:knowbre/shared/services/database.dart';

import '../search/search_page.dart';
import 'home_page.dart';

class HomePageController extends StatefulWidget {
  const HomePageController({Key? key}) : super(key: key);

  @override
  State<HomePageController> createState() => _HomePageControllerState();
}

class _HomePageControllerState extends State<HomePageController> {
  final User? _user = AuthServices().currentUser;

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
    return GetBuilder<AuthController>(
        init: AuthController(),
        builder: (controller) => controller.firestoreUser.value!.uid == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Scaffold(
                drawer: Drawer(
                  child: ListView(children: [
                    UserAccountsDrawerHeader(
                      currentAccountPicture: CircleAvatar(
                        backgroundImage: NetworkImage(_user?.photoURL ?? ''),
                      ),
                      accountName:
                          Text(controller.firestoreUser.value!.apelido),
                      accountEmail: Text(_user?.email ?? "User email"),
                    ),
                    ListTile(
                      dense: true,
                      title: Text('Profile'),
                      selected: true,
                      trailing: Icon(Icons.person),
                      onTap: () {},
                    ),
                  ]),
                ),
                appBar: AppBar(title: const Text("Knowbre")),
                body: PageStorage(
                  bucket: bucket,
                  child: currentScreen,
                ),
                floatingActionButton: FloatingActionButton(
                  child: Icon(Icons.add),
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
                                    Icons.home,
                                    color: currentTab == 0
                                        ? Colors.blue
                                        : Colors.grey,
                                  ),
                                  Text(
                                    'Home',
                                    style: TextStyle(
                                      color: currentTab == 0
                                          ? Colors.blue
                                          : Colors.grey,
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
                                    color: currentTab == 1
                                        ? Colors.blue
                                        : Colors.grey,
                                  ),
                                  Text(
                                    'Search',
                                    style: TextStyle(
                                      color: currentTab == 1
                                          ? Colors.blue
                                          : Colors.grey,
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
                                    color: currentTab == 3
                                        ? Colors.blue
                                        : Colors.grey,
                                  ),
                                  Text(
                                    'Cursos',
                                    style: TextStyle(
                                      color: currentTab == 3
                                          ? Colors.blue
                                          : Colors.grey,
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
                                    color: currentTab == 4
                                        ? Colors.blue
                                        : Colors.grey,
                                  ),
                                  Text(
                                    'Favoritos',
                                    style: TextStyle(
                                      color: currentTab == 4
                                          ? Colors.blue
                                          : Colors.grey,
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
              ));
  }
}
