import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:knowbre/pages/login/login.dart';
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
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage('assets/images/knowbre_regis.jpg'),
              colorFilter: ColorFilter.mode(Colors.black12, BlendMode.darken),
              fit: BoxFit.cover,
            )),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.black87, Colors.black.withOpacity(0.0)]),
            ),
          ),
          Column(
            children: [
              Container(
                alignment: Alignment.topCenter,
                child: Column(
                  children: [
                    Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 70, horizontal: 0),
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            text: 'Bem-vindo(a) ao ',
                            style: TextStyle(fontSize: 32),
                            children: const <TextSpan>[
                              TextSpan(
                                  text: 'Know',
                                  style: TextStyle(
                                      fontSize: 50,
                                      fontWeight: FontWeight.bold,
                                      color: AppColor.primary)),
                              TextSpan(
                                  text: 'Bre',
                                  style: TextStyle(
                                      fontSize: 50,
                                      fontWeight: FontWeight.w100,
                                      color: AppColor.primary)),
                            ],
                          ),
                        )),
                  ],
                ),
              ),
              Expanded(child: Container()),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    children: [
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 2.5, vertical: 20),
                        width: 150,
                        height: 80,
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: ElevatedButton(
                          onPressed: () {
                            Get.to(() => AuthPage());
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.background,
                            elevation: 0.0,
                          ),
                          child: const Text(
                            'Entrar',
                            style: TextStyle(
                              color: AppColor.primary,
                              letterSpacing: 1.5,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat',
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                        width: 150,
                        height: 80,
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: ElevatedButton(
                          onPressed: () {
                            Get.to(() => RegisterPage());
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            elevation: 0,
                            side: BorderSide(
                                color: AppColor.background, width: 2),
                          ),
                          child: const Text(
                            'Cadastra-se',
                            style: TextStyle(
                              color: AppColor.background,
                              letterSpacing: 1.5,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat',
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
