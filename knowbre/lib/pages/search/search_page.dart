import 'package:flutter/material.dart';
import 'package:knowbre/shared/themes/app_colors.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      body: (
        Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                    borderSide: BorderSide(color: AppColor.primary)),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                    borderSide: BorderSide(color: AppColor.primary)),
                  hintText: 'Pesquisar',
                )
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 200, left: 16, right: 16),
              child: Text(
              "Use a barra de pesquisa para buscar conteúdos", 
              style: TextStyle(color: Colors.grey),
              )
            )
          ],
        )
      )
    );
  }
}
