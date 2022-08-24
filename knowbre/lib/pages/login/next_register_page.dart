import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:knowbre/shared/themes/app_colors.dart';
import 'package:brasil_fields/brasil_fields.dart';

class NextRegisterPage extends StatefulWidget {
  const NextRegisterPage({Key? key}) : super(key: key);

  @override
  State<NextRegisterPage> createState() => _NextRegisterPageState();
}

class _NextRegisterPageState extends State<NextRegisterPage> {
  Widget _titleRegister() {
    return const Text(
      "Configure seu perfil",
      style: TextStyle(
        fontSize: 32,
        color: AppColor.primary,
      ),
    );
  }

  Widget _textFieldNome() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.only(bottom: 6.0),
          child: Text(
            'Nome',
            style: TextStyle(
              fontSize: 18.0,
              fontFamily: 'Montserrat',
            ),
          ),
        ),
        Container(
          height: 50.0,
          child: TextFormField(
            keyboardType: TextInputType.name,
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

  Widget _textFieldData() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.only(bottom: 6.0),
          child: Text(
            'Data de Nascimento',
            style: TextStyle(
              fontSize: 18.0,
              fontFamily: 'Montserrat',
            ),
          ),
        ),
        Container(
          height: 50.0,
          child: TextFormField(
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              DataInputFormatter(),
            ],
            decoration: const InputDecoration(
              suffixIcon: Icon(Icons.check_circle),
              border: OutlineInputBorder(),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColor.primary),
              ),
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
          'Registrar',
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
        Navigator.pushReplacementNamed(context, "/register");
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
                text: 'Voltar',
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
                  "Escolha uma foto de perfil",
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Montserrat',
                  ),
                ),
                const SizedBox(height: 30),
                Form(
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
                          const CircleAvatar(
                            radius: 100,
                            backgroundColor: Colors.grey,
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          _textFieldNome(),
                          const SizedBox(
                            height: 30.0,
                          ),
                          _textFieldData(),
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