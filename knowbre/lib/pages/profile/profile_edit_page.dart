import 'package:flutter/material.dart';
import 'package:knowbre/shared/constants/controllers.dart';
import 'package:knowbre/shared/themes/app_colors.dart';

class ProfileEditPage extends StatefulWidget {
  const ProfileEditPage({Key? key}) : super(key: key);

  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

// O que falta:
// - Colocar borda no botão
// - Trocar CircleAvatar por GestureDector
// - Colocar campo no firebase de formacao

class _ProfileEditPageState extends State<ProfileEditPage> {
  final _formKey = GlobalKey<FormState>();

  Widget _header() {
    return Container(
      width: double.infinity,
      height: 200,
      color: AppColor.background,
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: SizedBox(
              height: 30,
              width: 80,
              child: TextButton(
                style: TextButton.styleFrom(
                  textStyle: TextStyle(
                    fontSize: 12,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                  ),
                  backgroundColor: AppColor.background,
                  primary: AppColor.primary,
                ),
                onPressed: (() {}),
                child: const Text("Salvar"),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(
                  authController.firestoreUser.value?.photoURL ??
                      "https://www.zohowebstatic.com/sites/default/files/show/avatar_image.png",
                ),
                radius: 50,
              ),
            ],
          ),
          SizedBox(height: 15),
          Column(
            children: [
              Text(
                authController.firestoreUser.value?.nome ?? 'Nome completo',
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    color: AppColor.primary),
              ),
              Text(
                '@usuario',
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'Montserrat',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _textFieldFormEditNome() {
    return TextFormField(
      initialValue: authController.firestoreUser.value?.nome ?? 'Nome',
      maxLength: 20,
      decoration: InputDecoration(
        labelText: 'Nome',
        labelStyle: TextStyle(color: AppColor.primary),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColor.primary),
        ),
      ),
    );
  }
  Widget _textFieldFormEditFormacao() {
    return TextFormField(
      initialValue: authController.firestoreUser.value?.formacao ?? 'Formacao',
      maxLength: 20,
      decoration: InputDecoration(
        labelText: 'Formcao',
        labelStyle: TextStyle(color: AppColor.primary),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColor.primary),
        ),
      ),
    );
  }
  Widget _textFieldFormEditLocal() {
    return TextFormField(
      initialValue: authController.firestoreUser.value?.bio ?? 'Localização',
      maxLength: 20,
      decoration: InputDecoration(
        labelText: 'Nome',
        labelStyle: TextStyle(color: AppColor.primary),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColor.primary),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        backgroundColor: AppColor.background,
        iconTheme: IconThemeData(color: AppColor.primary),
        toolbarHeight: 40,
        shadowColor: AppColor.background,
        elevation: 1,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _header(),
              Form(
                key: _formKey,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20, 20, 30, 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      _textFieldFormEditNome(),
                      _textFieldFormEditFormacao(),
                      _textFieldFormEditLocal(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
