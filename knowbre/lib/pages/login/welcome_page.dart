import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:knowbre/shared/themes/app_images.dart';
import 'package:sign_in_button/sign_in_button.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                Center(
                    child: Image.asset(
                  AppImages.logo,
                  width: 300,
                  height: 300,
                  fit: BoxFit.fill,
                )),
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(
                left: 20,
                top: 10,
                right: 16,
                bottom: 10,
              ),
              child: Text(
                "Bem-vindo ao KnowBre",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            const Spacer(
              flex: 1,
            ),
            Column(
              children: [
                SignInButton(
                  Buttons.email,
                  text: "Entrar com email",
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, "/login");
                  },
                ),
                const Divider(
                  height: 15,
                  thickness: 1.5,
                  indent: 95,
                  endIndent: 95,
                  color: Colors.grey,
                ),
                SignInButton(
                  Buttons.googleDark,
                  text: "Entrar com google",
                  onPressed: () {},
                ),
                SignInButton(
                  Buttons.facebook,
                  text: "Entrar com facebook",
                  onPressed: () {},
                )
              ],
            ),
            const Spacer(
              flex: 1,
            ),
          ],
        ),
      ),
    );
  }
}
