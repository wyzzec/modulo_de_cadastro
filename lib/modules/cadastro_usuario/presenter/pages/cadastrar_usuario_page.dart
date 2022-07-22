import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../bloc/cadastrar_usuario_bloc.dart';
import '../widgets/cadastrar_usuario_widget.dart';

class CadastrarUsuarioPage extends StatefulWidget {
  const CadastrarUsuarioPage({Key? key, required CadastrarUsuarioBloc cadastrarUsuarioBloc}) : _cadastrarUsuarioBloc = cadastrarUsuarioBloc, super(key: key);

  final CadastrarUsuarioBloc _cadastrarUsuarioBloc;
  @override
  State<CadastrarUsuarioPage> createState() => _CadastrarUsuarioPageState();
}

class _CadastrarUsuarioPageState extends State<CadastrarUsuarioPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool willLeave = false;
        await showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  title: const Text('Você deseja descartar o cadastro e sair?'),
                  actions: [
                    TextButton(
                        onPressed: () {
                          willLeave = true;
                          Modular.to.navigate('/homepage/');
                        },
                        child: const Text('Sim')),
                    TextButton(
                        onPressed: () {
                          Modular.to.pop('/cadastrarusuario/');
                        },
                        child: const Text('Não'))
                  ],
                ));
        return willLeave;
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              CadastrarUsuarioWidget(cadastrarUsuarioBloc: widget._cadastrarUsuarioBloc),
            ],
          ),
        ),
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          title: const Text('Cadastro'),
          centerTitle: true,
          leading: Center(
            child: BackButton(
              onPressed: () =>
                  showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text('Você deseja descartar o cadastro e sair?'),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Modular.to.navigate('/homepage/');
                        },
                        child: const Text('Sim')),
                    TextButton(
                        onPressed: () {
                          Modular.to.pop('/cadastrarusuario/');
                        },
                        child: const Text('Não'))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
