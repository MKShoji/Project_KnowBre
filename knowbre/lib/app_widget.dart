import 'package:flutter/material.dart';
import 'package:knowbre/pages/home/home_page.dart';
import 'package:knowbre/pages/login/forgot_password_page.dart';
import 'package:knowbre/pages/login/login_page.dart';
import 'package:knowbre/pages/login/register_page.dart';
import 'package:knowbre/pages/login/welcome_page.dart';
import 'package:knowbre/pages/profile/profile_page.dart';
import 'package:knowbre/pages/splash/splash_page.dart';
import 'package:knowbre/shared/themes/app_colors.dart';

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
        primaryColor: AppColor.primary,
      ),
      initialRoute: '/login',
      routes: {
        '/splash': (_) => const SplashScreen(),
        '/welcome': (_) => const WelcomePage(),
        '/login': (_) => const AuthPage(),
        '/register': (_) => const RegisterPage(),
        '/forgot_password': (_) => const ForgotPasswordPage(),
        '/home': (_) => HomePage(),
        '/profile': (_) => const ProfilePage(),
      },
    );
  }
}
