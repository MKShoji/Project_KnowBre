import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import '../themes/app_colors.dart';

class CardPreview extends StatelessWidget {
  const CardPreview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     return Container(
      height: 200,
      child: Card(
        elevation: 5,
        margin: const EdgeInsets.all(10.0),
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            ListTile(
              //Icone do Usuário
              leading: CircleAvatar(backgroundImage: AssetImage('assets/images/default_avatar.png')),
              //Nome de Usuário
              title: Text(
                'Nome de Usuário',
                style: TextStyle(color: Colors.black.withOpacity(0.6)),
              ),
              subtitle: const Text(
                'Título do Card',
                style: TextStyle(color: AppColor.primary, fontSize: 22),
              ),
            ),
            //Imagem e Descrição/Parte do texto
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  child: Image.asset('assets/images/default_avatar.png', width: 80, height: 80)
                ),
                Expanded(
                  child: Text(
                    'Olha só que texto legal interessante super clicável extraordinário eletrizante chocante exuberante inteligente',
                    style: TextStyle(color: Colors.black.withOpacity(0.6)),
                  ),
                )
              ],
            ),
          ],
        ),
      )
    );
  }
}
