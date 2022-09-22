import 'package:flutter/material.dart';
import 'package:knowbre/shared/services/auth_controller.dart';
import 'package:knowbre/shared/themes/app_colors.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formkey = GlobalKey<FormState>();

  final _emailResetController = TextEditingController();

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

  Widget _redefineBtn() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      width: double.infinity,
      child: RaisedButton(
        onPressed: () {
          if (_formkey.currentState!.validate() == true) {
            AuthController()
                .resetPassword(email: _emailResetController.text)
                .then((value) {
              print('Resetar Senha');
            });
          }
        },
        padding: const EdgeInsets.all(15.0),
        color: AppColor.primary,
        shape: Border.all(color: AppColor.primary),
        child: const Text(
          'Redefinir Senha',
          style: TextStyle(
            color: AppColor.background,
            letterSpacing: 1.5,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'Montserrat',
          ),
        ),
      ),
    );
  }

  Widget _voltarBtn() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      width: double.infinity,
      child: RaisedButton(
        onPressed: () {
          Navigator.pushReplacementNamed(context, "/login");
        },
        padding: const EdgeInsets.all(15.0),
        color: AppColor.background,
        shape: Border.all(color: AppColor.primary),
        child: const Text(
          'Voltar',
          style: TextStyle(
            color: AppColor.primary,
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
            controller: _emailResetController,
            validator: ((value) {
              if (value!.isEmpty) {
                return "Por favor preencha o campo email";
              }
              if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                  .hasMatch(value)) {
                return ("Please Enter a valid email");
              }
            }),
            onSaved: (value) {
              _emailResetController.text = value!;
            },
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
        child: Form(
          key: _formkey,
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
                _redefineBtn(),
                _voltarBtn(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
