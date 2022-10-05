import 'package:flutter/material.dart';
import 'package:knowbre/shared/themes/app_colors.dart';

class ProfileEditPage extends StatefulWidget {
  const ProfileEditPage({Key? key}) : super(key: key);

  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
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
      body: Column(children: []),
    );
  }
}
