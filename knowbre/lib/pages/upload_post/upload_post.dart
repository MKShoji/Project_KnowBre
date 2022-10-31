import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:knowbre/pages/home/home.dart';
import 'package:knowbre/shared/constants/controllers.dart';
import 'package:knowbre/shared/themes/app_colors.dart';
import 'package:knowbre/shared/utilities/constants.dart';
import 'package:knowbre/shared/widgets/cardArticles_widget.dart';

class UploadPostPage extends StatefulWidget {
  const UploadPostPage({Key? key}) : super(key: key);

  @override
  State<UploadPostPage> createState() => _UploadPostPageState();
}

class _UploadPostPageState extends State<UploadPostPage> {
  File? banner;
  final _picker = ImagePicker();

  // Controller dos Inputs
  final _tituloController = TextEditingController();
  final _descricaoController = TextEditingController();

  bool _isLoading = false;
  String _blogId = '';

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

  Future _uploadPost(File? image, String title, String descricao) async {
    setState(() {
      _isLoading = true;
    });

    String id = generateId();

    DatabaseReference reference = await firebaseDatabase;
    var ref = await firebaseStorage
        .ref()
        .child("/fotos")
        .child("/posts")
        .child(image!.uri.toString() + ".jpg");
    var uploadTask = await ref.putFile(image);
    String downloadUrl = await uploadTask.ref.getDownloadURL();

    Map postData = {
      'image': downloadUrl,
      'title': title,
      'desc': descricao,
      'numArt': '$value',
    };

    await reference.child('Blogs').child(id).set(postData).whenComplete(() {
      setState(() {
        _isLoading = false;
      });
      Get.to(
        () => HomePageController(),
        transition: Transition.cupertino,
      );
    });
  }

  Widget _textFieldFormTitle() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      child: TextFormField(
        keyboardType: TextInputType.text,
        controller: _tituloController,
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

  Widget _textFieldFormDescricao() {
    return Container(
      height: 25,
      margin: EdgeInsets.fromLTRB(2.5, 1, 2.5, 20),
      child: TextFormField(
        keyboardType: TextInputType.text,
        controller: _descricaoController,
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
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.send),
          ),
        ],
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
              _textFieldFormDescricao(),
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
