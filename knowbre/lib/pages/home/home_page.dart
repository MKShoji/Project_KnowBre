import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:knowbre/app_widget.dart';
import 'package:knowbre/shared/auth/auth_services.dart';
import 'package:knowbre/shared/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final User? user = AuthServices().currentUser;

  Future<void> siginOut() async {
    await AuthServices().signOut();
  }

  Widget _title() {
    return const Text("Home");
  }

  Widget _signOutButton() {
    return ElevatedButton(
      onPressed: siginOut,
      child: const Text("Sign Out"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(user?.photoURL ?? ''),
            ),
            accountName: Text(user?.displayName ?? "User name"),
            accountEmail: Text(user?.email ?? "User email"),
          ),
          ListTile(
            dense: true,
            title: Text('Profile'),
            selected: true,
            trailing: Icon(Icons.person),
            onTap: () {
              Navigator.popAndPushNamed(context, '/profile');
            },
          ),
        ]),
      ),
      appBar: AppBar(
        title: _title(),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _signOutButton(),
          ],
        ),
      ),
    );
  }
}
