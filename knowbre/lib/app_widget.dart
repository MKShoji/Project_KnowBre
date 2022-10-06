import 'package:get/get.dart';
import 'package:knowbre/pages/home/home_page_controller.dart';
import 'package:knowbre/pages/login/forgot_password_page.dart';
import 'package:knowbre/pages/login/login_page.dart';
import 'package:knowbre/pages/login/next_register_page.dart';
import 'package:knowbre/pages/login/register_page.dart';
import 'package:knowbre/pages/login/welcome_page.dart';
import 'package:knowbre/pages/profile/profile_page.dart';
import 'package:knowbre/pages/splash/landing_page.dart';
import 'package:knowbre/shared/widgets/cardPreview_widget.dart';

import 'pages/profile/profile_edit_page.dart';

class AppWidget {
  AppWidget._();
  static final routes = [
    GetPage(name: '/', page: () => const SplashScreen()),
    GetPage(name: '/welcome', page: () => const WelcomePage()),
    GetPage(name: '/login', page: () => const AuthPage()),
    GetPage(name: '/register', page: () => const RegisterPage()),
    GetPage(name: '/register2', page: () => const NextRegisterPage()),
    GetPage(name: '/forgot_password', page: () => const ForgotPasswordPage()),
    GetPage(name: '/home', page: () => HomePageController()),
    GetPage(name: '/profile', page: () => ProfilePage()),
    GetPage(name: '/profile_edit', page: () => ProfileEditPage()),
    GetPage(name: '/card', page: () => CardPreview()),
  ];
}
