import 'package:flutter/material.dart';
import '../../cadastro_usuario/presenter/widgets/to_cadastrar_usuario_text_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        body: const Center(child: ToCadastrarUsuarioTextButton()),
      ),
    );
  }
}
