import 'package:flutter/material.dart';

class CursosPage extends StatelessWidget {
  const CursosPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Text(
          "Cursos",
          style: TextStyle(fontSize: 30, color: Colors.white),
        ),
      ),
    );
  }
}
