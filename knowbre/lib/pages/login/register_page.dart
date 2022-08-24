import 'dart:math';

import 'package:flutter/material.dart';
import 'package:knowbre/pages/login/next_register_page.dart';
import 'package:knowbre/shared/services/auth_services.dart';
import 'package:knowbre/shared/themes/app_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:knowbre/shared/utilities/constants.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final nameController = TextEditingController();

  Widget _titleRegister() {
    return const Text(
      "Cadastrar-se",
      style: TextStyle(
        fontSize: 32,
        color: AppColor.primary,
      ),
    );
  }

  Widget _textFieldNameForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.only(bottom: 6.0),
          child: Text(
            'Nome',
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),
        ),
        Container(
          height: 50.0,
          child: TextFormField(
            keyboardType: TextInputType.name,
            controller: nameController,
            validator: (value) {
              RegExp regex = RegExp('[a-zA-Z]');
              if (value!.isEmpty) {
                return "Por favor preencha o campo";
              } else if (!regex.hasMatch(value)) {
                return "Seu username deve conter pelo menos 6 caracteres";
              }
            },
            onSaved: (value) {
              nameController.text = value!;
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

  Widget _textFieldEmailForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.only(bottom: 6.0),
          child: Text(
            'Email',
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),
        ),
        Container(
          height: 50.0,
          child: TextFormField(
            keyboardType: TextInputType.emailAddress,
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
              emailController.text = value!;
            },
            controller: emailController,
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

  Widget _textFieldPasswordForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.only(bottom: 6.0),
          child: Text(
            'Senha',
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),
        ),
        Container(
          height: 50.0,
          child: TextFormField(
            keyboardType: TextInputType.visiblePassword,
            obscureText: true,
            controller: passwordController,
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
              passwordController.text = value!;
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

  Widget _textFieldConfirmPasswordForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.only(bottom: 6.0),
          child: Text(
            'Confirmar Senha',
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),
        ),
        Container(
          height: 50.0,
          child: TextFormField(
            keyboardType: TextInputType.visiblePassword,
            controller: confirmPasswordController,
            validator: (value) {
              if (confirmPasswordController.text != passwordController.text) {
                return "Password don't match";
              }
              return null;
            },
            onSaved: (value) {
              confirmPasswordController.text = value!;
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

  Widget _registerBtn() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        onPressed: () {
          if (_formKey.currentState!.validate() == true) {
            try {
              AuthServices()
                  .createUserWithEmailAndPassword(emailController.text,
                      passwordController.text, nameController.text)
                  .then((value) => {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const NextRegisterPage(),
                          ),
                        ),
                      });
            } on FirebaseException catch (e) {
              if (e.code == 'weak-password') {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Senha fraca"),
                  ),
                );
              } else if (e.code == "email-already-in-use") {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Email já está sendo utilizado"),
                  ),
                );
              }
            }
          }
        },
        padding: const EdgeInsets.all(15.0),
        color: AppColor.primary,
        child: const Text(
          'Próximo',
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

  Widget _buildSignInButton() {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacementNamed(context, "/login");
      },
      child: Center(
        child: RichText(
          text: const TextSpan(
            children: [
              TextSpan(
                text: 'Já possui uma conta? ',
                style: TextStyle(
                  color: Color(0xFF4A4A4A),
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
              TextSpan(
                text: 'Entar',
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 30, 30),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _titleRegister(),
                const SizedBox(height: 15),
                const Text(
                  "Cadastre-se utilizando seu e-mail",
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Montserrat',
                  ),
                ),
                const SizedBox(height: 30),
                Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          const SizedBox(
                            height: 15.0,
                          ),
                          _textFieldNameForm(),
                          const SizedBox(
                            height: 15.0,
                          ),
                          _textFieldEmailForm(),
                          const SizedBox(
                            height: 15.0,
                          ),
                          _textFieldPasswordForm(),
                          const SizedBox(
                            height: 15.0,
                          ),
                          _textFieldConfirmPasswordForm(),
                          const SizedBox(
                            height: 10.0,
                          ),
                          _registerBtn(),
                          _buildSignInButton(),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
