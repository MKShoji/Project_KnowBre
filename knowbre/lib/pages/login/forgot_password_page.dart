import 'package:flutter/material.dart';
import 'package:knowbre/shared/themes/app_colors.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  Widget _titleLogin() {
    return const Text(
      "Esqueci minha senha",
      style: TextStyle(
        fontSize: 32,
        color: AppColor.primary,
      ),
    );
  }

  Widget _textHeader() {
    return Container(
      width: 320,
      child: const Text(
        "Informe seu e-mail e nós lhe enviaremos um link para redefinir sua senha :",
        style: TextStyle(
          fontSize: 20,
          fontFamily: 'Montserrat',
        ),
      ),
    );
  }

  Widget _redefineBtn(AppColor1, AppColor2, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      width: double.infinity,
      child: RaisedButton(
        onPressed: () {
          if (text == 'Voltar') {
            Navigator.pushReplacementNamed(context, "/login");
          }
        },
        padding: const EdgeInsets.all(15.0),
        color: AppColor1,
        shape: Border.all(color: AppColor.primary),
        child: Text(
          text,
          style: TextStyle(
            color: AppColor2,
            letterSpacing: 1.5,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'Montserrat',
          ),
        ),
      ),
    );
  }

  Widget _textFieldFormEmail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.only(bottom: 6.0),
          child: Text(
            'Email',
            style: TextStyle(
              fontSize: 18.0,
              fontFamily: 'Montserrat',
            ),
          ),
        ),
        Container(
          height: 50.0,
          child: TextFormField(
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              suffixIcon: Icon(Icons.check_circle),
              border: OutlineInputBorder(),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColor.primary)),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 20, 30, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _titleLogin(),
              const SizedBox(
                height: 20.0,
              ),
              _textHeader(),
              const SizedBox(
                height: 20.0,
              ),
              _textFieldFormEmail(),
              Spacer(),
              _redefineBtn(
                  AppColor.primary, AppColor.background, 'Redefinir senha'),
              _redefineBtn(AppColor.background, AppColor.primary, 'Voltar'),
            ],
          ),
        ),
      ),
    );
  }
}
