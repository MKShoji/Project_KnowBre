import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import '../themes/app_colors.dart';

class CardPreview extends StatelessWidget {
  const CardPreview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      child: Card(
        elevation: 5,
        margin: const EdgeInsets.all(10.0),
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            ListTile(
              //Icone do Usuário
              leading: Icon(Icons.arrow_drop_down_circle),
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
            //Descrição/Parte do texto
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Olha só que texto legal interessante super clicável extraordinário eletrizante chocante exuberante inteligente bonito bem formatado informado estilizado fertilizado vernizado',
                style: TextStyle(color: Colors.black.withOpacity(0.6)),
              ),
            ),
          ],
        ),
      )
    );
  }
}
