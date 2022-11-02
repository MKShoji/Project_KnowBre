import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
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

  final DateTime timestamp = DateTime.now();

  // Controller dos Inputs
  final _tituloController = TextEditingController();
  final _descricaoController = TextEditingController();

  bool _isUploading = false;
  String postId = generateId();

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

  Future uploadImage(File image) async {
    var ref = firebaseStorage
        .ref()
        .child("/fotos")
        .child("/posts")
        .child("post_$postId.jpg");
    var uploadtask = await ref.putFile(image);
    String downloadUrl = await uploadtask.ref.getDownloadURL();
    return downloadUrl;
  }

  createPostFirestore(
      {required String mediaUrl,
      required String title,
      required String description}) {
    firebaseFirestore
        .collection("posts")
        .doc(authController.firebaseAuth.currentUser!.uid)
        .collection('userPost')
        .doc(postId)
        .set({
      "postId": postId,
      "ownerId": authController.firebaseAuth.currentUser!.uid,
      "username": authController.firestoreUser.value!.username,
      "mediaUrl": mediaUrl,
      "title": title,
      "description": description,
      "timestamp": timestamp,
      "likes": {},
    });
  }

  int value = 1;
  _addItem() {
    setState(() {
      value = value + 1;
    });
  }

  handleSubmit() async {
    setState(() {
      _isUploading = true;
    });
    String mediaUrl = await uploadImage(banner!);
    createPostFirestore(
      mediaUrl: mediaUrl,
      title: _tituloController.text,
      description: _descricaoController.text,
    );
    _tituloController.clear();
    _descricaoController.clear();
    setState(() {
      banner == null;
      _isUploading = false;
      postId = generateId();
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
            onPressed: _isUploading ? null : () => handleSubmit(),
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
            children: <Widget>[
              _isUploading ? LinearProgressIndicator() : Text(''),
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
