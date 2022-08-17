import 'package:flutter/material.dart';
import 'package:knowbre/shared/themes/app_colors.dart';
import 'package:knowbre/shared/utilities/constants.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  Widget _titleRegister() {
    return const Text(
      "Cadastrar-se",
      style: TextStyle(
        fontSize: 32,
        color: AppColor.primary,
      ),
    );
  }

  Widget _textFieldForm(String label, TextInputType) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 6.0),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 16.0,
            ),
          ),
        ),
        Container(
          height: 40.0,
          child: TextFormField(
            keyboardType: TextInputType,
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
        onPressed: () => print('Register Button Pressed'),
        padding: const EdgeInsets.all(15.0),
        color: AppColor.primary,
        child: const Text(
          'Criar conta',
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
                const SizedBox(height: 30),
                Form(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          const CircleAvatar(
                            radius: 50,
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          _textFieldForm(
                            'Nome',
                            TextInputType.name,
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          _textFieldForm(
                            'Email',
                            TextInputType.emailAddress,
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          _textFieldForm(
                            'Senha',
                            TextInputType.visiblePassword,
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          _textFieldForm(
                            'Confirmar senha',
                            TextInputType.visiblePassword,
                          ),
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
