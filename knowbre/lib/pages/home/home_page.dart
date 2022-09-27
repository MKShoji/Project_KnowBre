import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:knowbre/shared/models/user.dart';
import 'package:knowbre/shared/services/auth_controller.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<void> siginOut() async {
    await AuthController().signOut();
  }

  Future<void> siginOutGoogle() async {
    await AuthController().signOutGoogle();
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

  Widget _signOutGoogleButton() {
    return ElevatedButton(
        onPressed: siginOutGoogle, child: const Text("Sign Out Google"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _signOutButton(),
            _signOutGoogleButton(),
          ],
        ),
      ),
    );
  }
}
