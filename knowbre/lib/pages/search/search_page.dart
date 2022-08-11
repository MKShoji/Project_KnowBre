import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.green,
      body: Center(
        child: Text(
          "Pesquisar",
          style: TextStyle(fontSize: 30, color: Colors.white),
        ),
      ),
    );
  }
}
