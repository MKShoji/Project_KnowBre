import 'package:flutter/material.dart';
import 'package:knowbre/shared/themes/app_colors.dart';

class ProfileImagePick extends StatelessWidget {
  final String imagePath;
  final VoidCallback onClicked;
  const ProfileImagePick(
      {Key? key, required this.imagePath, required this.onClicked})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(children: [
        buildImage(),
      ]),
    );
  }

  Widget buildImage() {
    final image = NetworkImage(imagePath);

    return ClipOval(
      child: Material(
        color: AppColor.profilePick,
        child: Ink.image(
          image: image,
          fit: BoxFit.cover,
          width: 150,
          height: 150,
          child: InkWell(onTap: onClicked),
        ),
      ),
    );
  }
}
