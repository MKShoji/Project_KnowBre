import 'dart:io';

import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:knowbre/shared/constants/controllers.dart';
import 'package:knowbre/shared/services/database.dart';
import 'package:knowbre/shared/themes/app_colors.dart';

class ProfileEditPage extends StatefulWidget {
  const ProfileEditPage({Key? key}) : super(key: key);

  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

// O que falta:
// - Trocar CircleAvatar por GestureDector

class _ProfileEditPageState extends State<ProfileEditPage> {
  final _formKey = GlobalKey<FormState>();

  XFile? photo;
  final ImagePicker _picker = ImagePicker();

  final apelidoController = TextEditingController();
  final dataController = TextEditingController(
    text: UtilData.obterDataDDMMAAAA(DateTime(2022, 12, 31)),
  );
  final formacaoController = TextEditingController();
  final localizacaoController = TextEditingController();

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
              child: OutlineButton(
                textColor: AppColor.primary,
                onPressed: () async {
                  if (_formKey.currentState!.validate() == true) {
                    await uploadPfp().then((value) async {});
                    String value = await getDownload();
                    DatabaseMethods()
                        .firebaseFirestore
                        .collection("users")
                        .doc(authController.user?.uid)
                        .update({
                      'apelido': apelidoController.text,
                      'dateNasc': dataController.text,
                      'formacao': formacaoController.text,
                      'localizacao': localizacaoController.text,
                      'photoURL': value != null ? value : "",
                    }).then(
                      ((value) => Get.back()),
                    );
                  }
                },
                child: const Text("Salvar"),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  pickImage();
                },
                child: CircleAvatar(
                  backgroundImage:
                      photo != null ? FileImage(File(photo!.path)) : null,
                  radius: 50,
                  child: photo == null
                      ? const Icon(
                          Icons.add_a_photo,
                          color: AppColor.profilePickIcon,
                          size: 60,
                        )
                      : null,
                ),
              ),
            ],
          ),
          SizedBox(height: 15),
          Column(
            children: [
              Text(
                authController.firestoreUser.value?.apelido ?? 'Nome completo',
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
      keyboardType: TextInputType.name,
      controller: apelidoController,
      validator: (value) {
        RegExp regex = RegExp(r'^.{2,}$');
        if (value!.isEmpty) {
          return ("Por favor preencher campo obrigatório");
        }
        if (!regex.hasMatch(value)) {
          return ("Nome deve conter pelo menos mais de 2 caracteres");
        }
      },
      onSaved: (value) {
        apelidoController.text = value!;
      },
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
      controller: formacaoController,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Por favor preencher campo obrigatório");
        }
      },
      onSaved: (value) {
        formacaoController.text = value!;
      },
      maxLength: 50,
      decoration: InputDecoration(
        labelText: 'Formacao',
        labelStyle: TextStyle(color: AppColor.primary),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColor.primary),
        ),
      ),
    );
  }

  Widget _textFieldFormEditLocal() {
    return TextFormField(
      controller: localizacaoController,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Por favor preencher campo obrigatório");
        }
      },
      onSaved: (value) {
        localizacaoController.text = value!;
      },
      maxLength: 50,
      decoration: InputDecoration(
        labelText: 'Localização',
        labelStyle: TextStyle(color: AppColor.primary),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColor.primary),
        ),
      ),
    );
  }

  Widget _textFieldFormEditDataNasc() {
    return TextFormField(
      controller: dataController,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Por favor preencher campo obrigatório");
        }
      },
      onSaved: (value) {
        dataController.text = value!;
      },
      maxLength: 10,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        DataInputFormatter(),
      ],
      decoration: InputDecoration(
        labelText: 'Data de nascimento',
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
        title: const Text(
          "Editar Perfil",
          style: TextStyle(
            color: AppColor.primary,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
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
                      _textFieldFormEditDataNasc(),
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

  Future pickImage() async {
    photo = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {});
  }

  Future<void> uploadPfp() async {
    File uploadFile = File(photo!.path);

    try {
      await firebaseStorage.ref('/fotos/profilePic/${uploadFile.path}').putFile(
          uploadFile != null ? uploadFile : File('assets/default_avatar.png'));
    } catch (e) {
      print(e);
    }
  }

  Future<String> getDownload() async {
    File uploadedFile = File(photo!.path);

    return firebaseStorage
        .ref('/fotos/profilePic/${uploadedFile.path}')
        .getDownloadURL();
  }
}
