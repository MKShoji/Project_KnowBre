import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:knowbre/shared/themes/app_colors.dart';
import 'package:knowbre/shared/widgets/cardArticles_widget.dart';

class UploadPostPage extends StatefulWidget {
  const UploadPostPage({Key? key}) : super(key: key);

  @override
  State<UploadPostPage> createState() => _UploadPostPageState();
}

class _UploadPostPageState extends State<UploadPostPage> {
  File? banner;
  final _picker = ImagePicker();

  Future pickImage() async {
    final pickedfile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedfile != null) {
        banner = File(pickedfile.path);
      } else {
        print('Sem imagem');
      }
    });
  }

  int value = 1;

  _addItem() {
    setState(() {
      value = value + 1;
    });
  }

  Widget _textFieldFormTitle() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      child: TextFormField(
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          labelText: 'Título',
          labelStyle: TextStyle(color: AppColor.primary, fontSize: 12),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColor.primary),
          ),
        ),
      ),
    );
  }

  Widget _bannerPost() {
    return GestureDetector(
      onTap: () {
        pickImage();
      },
      child: banner != null
          ? Container(
              height: 150,
              margin: EdgeInsets.symmetric(vertical: 24),
              width: MediaQuery.of(context).size.width,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                child: Image.file(
                  banner!,
                  fit: BoxFit.cover,
                ),
              ),
            )
          : Container(
              height: 150,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              margin: EdgeInsets.symmetric(vertical: 20),
              width: MediaQuery.of(context).size.width,
              child: Icon(Icons.camera_alt),
            ),
    );
  }

  Widget _textFieldFormFonte() {
    return Container(
      height: 25,
      margin: EdgeInsets.fromLTRB(2.5, 1, 2.5, 20),
      child: TextFormField(
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          hintText: "Autor(a) ou Fonte",
          hintStyle: TextStyle(color: AppColor.profilePickIcon, fontSize: 14),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColor.primary),
          ),
        ),
      ),
    );
  }

  // Arrumar a lista

  Widget articlesList() {
    return Container(
      child: SingleChildScrollView(
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: this.value,
          itemBuilder: (context, index) => CardArticles(
            index: index,
          ),
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
          "Criar Post",
          style: TextStyle(
            color: AppColor.primary,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: 15,
          ),
          child: Column(
            children: [
              _textFieldFormTitle(),
              _bannerPost(),
              _textFieldFormFonte(),
              articlesList(),
              TextButton.icon(
                onPressed: _addItem,
                icon: Icon(Icons.add, color: AppColor.primary),
                label: Text(
                  "Adicionar",
                  style: TextStyle(color: AppColor.primary),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
