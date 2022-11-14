import 'package:flutter/material.dart';
import 'package:knowbre/shared/themes/app_colors.dart';
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
      body: Stack(children: [
        Container(
            decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/knowbre_regis.jpg'),
              fit: BoxFit.cover),
        )),
        Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.black, Colors.black.withOpacity(0.0)]))),
        Column(
          children: [
            Container(
                margin: EdgeInsets.symmetric(vertical: 100, horizontal: 0),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: 'Bem-vindo(a) ao ',
                    style: TextStyle(fontSize: 30),
                    children: const <TextSpan>[
                      TextSpan(
                          text: 'Know',
                          style: TextStyle(
                              fontSize: 70,
                              fontWeight: FontWeight.bold,
                              color: AppColor.primary)),
                      TextSpan(
                          text: 'Bre',
                          style: TextStyle(
                              fontSize: 70,
                              fontWeight: FontWeight.w100,
                              color: AppColor.primary)),
                    ],
                  ),
                )),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                children: [
                  Container(
                    width: 160,
                    child: OutlinedButton(
                      child: Text(
                        "Entrar",
                        style: TextStyle(fontSize: 20, color: AppColor.primary),
                      ),
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15)
                      ),
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, "/login");
                      },
                    ),
                  ),
                  Container(
                    width: 160,
                    child: OutlinedButton(
                      child: Text(
                        "Cadastre-se",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      style: OutlinedButton.styleFrom(
                        backgroundColor: AppColor.primary,
                        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15)
                      ),
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, "/register");
                      },
                    ),
                  ),
                ]
              ),
            ],
          )
        ]
      )
    );
  }
}
