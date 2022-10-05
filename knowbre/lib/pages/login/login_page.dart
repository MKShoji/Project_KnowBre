import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:knowbre/pages/login/login.dart';
import 'package:knowbre/shared/services/auth_controller.dart';
import 'package:knowbre/shared/themes/app_colors.dart';
import 'package:sign_in_button/sign_in_button.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _formKey = GlobalKey<FormState>();

  final authController = AuthController();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Widget _titleLogin() {
    return const Text(
      "Entrar",
      style: TextStyle(
        fontSize: 32,
        color: AppColor.primary,
      ),
    );
  }

  Widget _textHeader() {
    return Container(
      width: 250,
      child: const Text(
        "Entre utilizando uma das seguintes opções:",
        style: TextStyle(
          fontSize: 20,
          fontFamily: 'Montserrat',
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
            controller: _emailController,
            validator: (value) {
              if (value!.isEmpty) {
                return "Por favor preencha o campo email";
              }
              if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                  .hasMatch(value)) {
                return ("Please Enter a valid email");
              }
            },
            onSaved: (value) {
              _emailController.text = value!;
            },
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              suffixIcon: Icon(Icons.email_outlined),
              border: OutlineInputBorder(),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColor.primary)),
            ),
          ),
        ),
      ],
    );
  }

  Widget _textFieldFormPassword() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.only(bottom: 6.0),
          child: Text(
            'Senha',
            style: TextStyle(
              fontSize: 18.0,
              fontFamily: 'Montserrat',
            ),
          ),
        ),
        Container(
          height: 50.0,
          child: TextFormField(
            controller: _passwordController,
            validator: (value) {
              RegExp regex = RegExp(r'^.{6,}$');
              if (value!.isEmpty) {
                return ("Password is required for login");
              }
              if (!regex.hasMatch(value)) {
                return ("Enter Valid Password(Min. 6 Character)");
              }
            },
            onSaved: (value) {
              _passwordController.text = value!;
            },
            obscureText: true,
            decoration: const InputDecoration(
              suffixIcon: Icon(Icons.lock),
              border: OutlineInputBorder(),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColor.primary)),
            ),
          ),
        ),
      ],
    );
  }

  Widget _loginBtn() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        onPressed: () {
          if (_formKey.currentState!.validate() == true) {
            AuthController()
                .signIn(
                    email: _emailController.text,
                    password: _passwordController.text)
                .then((value) {});
          }
        },
        padding: const EdgeInsets.all(15.0),
        color: AppColor.primary,
        child: const Text(
          'Entrar',
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 1.5,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'Montserrat',
          ),
        ),
      ),
    );
  }

  Widget _buildSignUpButton() {
    return GestureDetector(
      onTap: () {
        Get.to(() => RegisterPage(), transition: Transition.rightToLeft);
      },
      child: Center(
        child: RichText(
          text: const TextSpan(
            children: [
              TextSpan(
                text: 'Ainda não possui uma conta ? ',
                style: TextStyle(
                  color: Color(0xFF4A4A4A),
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
              TextSpan(
                text: 'Cadastre-se',
                style: TextStyle(
                  color: AppColor.primary,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildForgotPasswordBtn() {
    return Container(
      alignment: Alignment.centerRight,
      child: FlatButton(
        onPressed: () {
          Get.to(
            () => ForgotPasswordPage(),
            transition: Transition.cupertino,
          );
        },
        padding: EdgeInsets.only(right: 0.0),
        child: const Text(
          'Esqueceu sua senha?',
          style: TextStyle(
            color: AppColor.primary,
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 30, 30),
            child: SingleChildScrollView(
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
                  SignInButton(
                    Buttons.googleDark,
                    onPressed: () {
                      AuthController().googleSignIn();
                    },
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  const Text(
                    "Ou entre utilizando seu e-mail:",
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  _textFieldFormEmail(),
                  const SizedBox(
                    height: 10.0,
                  ),
                  _textFieldFormPassword(),
                  _buildForgotPasswordBtn(),
                  _loginBtn(),
                  _buildSignUpButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
