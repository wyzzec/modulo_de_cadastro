import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ErroNoServidorPopUpWidget extends StatelessWidget {
  const ErroNoServidorPopUpWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Icon(Icons.error,
        color: Colors.red,),
      content: const Text(
        'Erro no servidor, por favor tente mais tarde.',
      ),
      actions: [
        TextButton(
            onPressed: () {
              Modular.to.pop('/cadastrarusuario/');
            },
            child: const Text('Ok'))
      ],
    );
  }
}