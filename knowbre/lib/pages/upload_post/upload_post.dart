import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html_editor_enhanced/html_editor.dart';
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
  final textoController = HtmlEditorController();

  bool _isUploading = false;
  String postId = generateId();
  String articleId = generateIdArticle();

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
      required String description,
      required String text}) {
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
          "text": text,
          "timestamp": timestamp,
          "likes": {},
          "articlesNum": value,
        })
        .then((value) => Get.defaultDialog(
              title: "Sucesso !",
              middleText: "Seus Post foi enviado com sucesso",
              backgroundColor: AppColor.backgroundList,
              titleStyle: TextStyle(color: AppColor.primary, fontSize: 22),
              radius: 30,
            ))
        .then(
          (value) => Get.back(),
        );
  }

  createPostArticle(
      {required String title, required String text, String? mediaUrl}) {
    firebaseFirestore
        .collection("articles")
        .doc(postId)
        .collection('articlePost')
        .doc(articleId)
        .set({
      "articleId": articleId,
      "postId": postId,
      "title": title,
      "text": text,
      "mediaUrl": mediaUrl,
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
    String dataTxt = await textoController.getText();
    createPostFirestore(
      mediaUrl: mediaUrl,
      title: _tituloController.text,
      description: _descricaoController.text,
      text: dataTxt,
    );
    _tituloController.clear();
    _descricaoController.clear();
    textoController.clear();
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
      margin: EdgeInsets.fromLTRB(2.5, 10, 2.5, 20),
      child: TextFormField(
        keyboardType: TextInputType.multiline,
        maxLength: 30,
        maxLines: 2,
        controller: _descricaoController,
        decoration: InputDecoration(
          hintText: "Descricao",
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
              _isUploading
                  ? LinearProgressIndicator(
                      color: AppColor.primary,
                    )
                  : Text(''),
              _textFieldFormTitle(),
              _bannerPost(),
              _textFieldFormDescricao(),
              // articlesList(),
              // TextButton.icon(
              //   onPressed: _addItem,
              //   icon: Icon(Icons.add, color: AppColor.primary),
              //   label: Text(
              //     "Adicionar",
              //     style: TextStyle(color: AppColor.primary),
              //   ),
              // )
              SizedBox(
                height: 20,
              ),
              HtmlEditor(
                controller: textoController,
                htmlEditorOptions: HtmlEditorOptions(
                  hint: "Digite um texto",
                  autoAdjustHeight: true,
                ),
                otherOptions: OtherOptions(
                  height: 600,
                ),
                htmlToolbarOptions: HtmlToolbarOptions(
                  toolbarType: ToolbarType.nativeGrid,
                  toolbarPosition: ToolbarPosition.aboveEditor,
                  defaultToolbarButtons: [
                    FontSettingButtons(
                        fontName: true, fontSize: true, fontSizeUnit: true),
                    FontButtons(
                        subscript: false, superscript: false, clearAll: false),
                    ListButtons(listStyles: false),
                    InsertButtons(
                      audio: false,
                      hr: false,
                      otherFile: false,
                      table: false,
                    ),
                    OtherButtons(
                      codeview: false,
                      help: false,
                      redo: false,
                      undo: false,
                      fullscreen: false,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
