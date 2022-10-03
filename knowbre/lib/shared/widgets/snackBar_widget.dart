import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:knowbre/shared/themes/app_colors.dart';

class SnackBars extends StatelessWidget {
  final String titulo;
  final String mensagem;
  final int typeOfSnackbar;
  SnackBars(
      {Key? key,
      required this.titulo,
      required this.mensagem,
      required this.typeOfSnackbar})
      : super(key: key);

  SnackbarController _snackBarError() {
    return Get.snackbar(
      titulo,
      mensagem,
      animationDuration: Duration(seconds: 1),
      backgroundColor: AppColor.snackBarBackground,
      colorText: AppColor.background,
      icon: Icon(Icons.error_outline, color: AppColor.primary),
      snackPosition: SnackPosition.BOTTOM,
      snackStyle: SnackStyle.GROUNDED,
      reverseAnimationCurve: Curves.bounceIn,
    );
  }

  SnackbarController _snackBarValidator() {
    return Get.snackbar(
      titulo,
      mensagem,
      icon: Icon(Icons.check_circle_outline, color: AppColor.primary),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColor.snackBarBackground,
      colorText: AppColor.background,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(children: []),
    );
  }
}
