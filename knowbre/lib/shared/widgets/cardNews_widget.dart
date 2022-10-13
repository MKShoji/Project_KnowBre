import 'package:flutter/material.dart';
import 'package:knowbre/shared/themes/app_colors.dart';

class CardNews extends StatelessWidget {
  final String child;
  const CardNews({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        height: 150,
        color: AppColor.background,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            child,
            style: TextStyle(
              fontSize: 22,
              color: AppColor.primary,
            ),
          ),
        ),
      ),
    );
  }
}
