import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CadastroRealizadoPopupWidget extends StatelessWidget {
  const CadastroRealizadoPopupWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Cadastro realizado com sucesso!!'),
      content: const Icon(Icons.check,
        color: Colors.green,),
      actions: [
        TextButton(
          onPressed: () {
            Modular.to.navigate('/homepage/');
          },
          child: const Text('Ok'),
        ),
      ],
    );
  }
}
