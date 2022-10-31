import 'package:flutter/material.dart';
import 'package:knowbre/shared/models/post.dart';
import '../themes/app_colors.dart';

class CardPreview extends StatelessWidget {
  final Post data;
  const CardPreview({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Color(0xff101010),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 200.0,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5.0),
                      topRight: Radius.circular(5.0)),
                  child: Image(
                    image: NetworkImage(data.imagem),
                    filterQuality: FilterQuality.high,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                    color: Colors.black45,
                    colorBlendMode: BlendMode.darken,
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 60.0,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Colors.transparent, Color(0xff101010)],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter)),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(data.titulo,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    )),
                SizedBox(height: 10.0),
                Text(data.descricao,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
