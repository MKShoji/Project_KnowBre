import 'package:flutter/material.dart';
import 'package:knowbre/pages/home/home_page.dart';
import 'package:knowbre/pages/login/login_page.dart';
import 'package:knowbre/pages/login/welcome_page.dart';
import 'package:knowbre/pages/profile/profile_page.dart';
import 'package:knowbre/pages/splash/splash_page.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  State<AppWidget> createState() => _AppWigetState();
}

class _AppWigetState extends State<AppWidget> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KnowBre',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/splash',
      routes: {
        '/splash': (_) => const SplashScreen(),
        '/welcome': (_) => const WelcomePage(),
        '/login': (_) => const AuthPage(),
        '/home': (_) => HomePage(),
        '/profile': (_) => const ProfilePage(),
      },
    );
  }
}
