import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ToCadastrarUsuarioTextButton extends StatelessWidget {
  const ToCadastrarUsuarioTextButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ElevatedButton.styleFrom(fixedSize: Size(170, 30)),
      onPressed: () {
        Modular.to.pushNamed('./cadastrarusuario/');
      },
      child: const Text('Registrar usuário'),
    );
  }
}