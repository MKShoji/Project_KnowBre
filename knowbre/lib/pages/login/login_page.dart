import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:knowbre/pages/home/home_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return SignInScreen(
            providerConfigs: const [
              EmailProviderConfiguration(),
              GoogleProviderConfiguration(
                  clientId:
                      '338298446122-o4og2bpghbmnjoekmfh656do5pdbuc80.apps.googleusercontent.com'),
            ],
            footerBuilder: (context, action) {
              return Padding(
                  padding: EdgeInsets.all(8.0),
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.popAndPushNamed(context, '/welcome');
                      },
                      child: const Text('Voltar')));
            },
          );
        }
        return HomePage();
      },
    );
  }
}
