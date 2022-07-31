import 'package:flutter/material.dart';
import 'package:knowbre/pages/home/home_page.dart';
import 'package:knowbre/pages/login/login_page.dart';
import 'package:knowbre/pages/login/welcome_page.dart';
import 'package:knowbre/pages/splash/splash_page.dart';
import 'package:knowbre/shared/auth/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AppWiget extends StatefulWidget {
  const AppWiget({Key? key}) : super(key: key);

  @override
  State<AppWiget> createState() => _AppWigetState();
}

class _AppWigetState extends State<AppWiget> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Auth().auhtStateChanges,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return HomePage();
          } else {
            return const LoginPage();
          }
        });
  }
}


///      initialRoute: '/splash',
///     routes: {
///        '/splash': (_) => const SplashPage(),
///        '/welcome': (_) => const WelcomePage(),
///        '/login': (_) => const LoginPage(),
///       '/home': (_) => HomePage(),
///      },
