import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:brasil_fields/brasil_fields.dart';

import '../../../../global/utils/sizes/sizes_for_text_fields.dart';
import '../../domain/entities/endereco_entity.dart';
import '../../domain/entities/usuario_entity.dart';
import '../bloc/cadastrar_usuario_bloc.dart';
import '../bloc/cadastrar_usuario_bloc_events/cadastrar_usuario_bloc_event_salvar_cadastro.dart';
import '../bloc/cadastrar_usuario_bloc_states/cadastrar_usuario_bloc_state_error.dart';
import '../bloc/cadastrar_usuario_bloc_states/cadastrar_usuario_bloc_state_loading.dart';
import '../bloc/cadastrar_usuario_bloc_states/cadastrar_usuario_bloc_state_sucess.dart';
import '../bloc/cadastrar_usuario_bloc_states/i_cadastrar_usuario_bloc_state.dart';
import 'cadastro_realizado_popup_widget.dart';
import 'erro_no_servidor_popup_widget.dart';

class CadastrarUsuarioWidget extends StatefulWidget {
  const CadastrarUsuarioWidget({Key? key, required CadastrarUsuarioBloc cadastrarUsuarioBloc}) :  _cadastrarUsuarioBloc = cadastrarUsuarioBloc, super(key: key);

  final CadastrarUsuarioBloc _cadastrarUsuarioBloc;

  @override
  State<CadastrarUsuarioWidget> createState() => _CadastrarUsuarioWidgetState();
}

class _CadastrarUsuarioWidgetState extends State<CadastrarUsuarioWidget> {
  final double? espacoEntreInputs = 35;
  final double? espacoEntreCards = 15;
  final double? cardElevation = 5;
  final SizesForTextFields sizesForTextFields = SizesForTextFields();
  final regex = RegExp(r'^(?=.*?[a-z])(?=.*?[0-9]).{8,}$');
  final formKey = GlobalKey<FormState>();
  final nomeController = TextEditingController();
  final emailController = TextEditingController();
  final telefoneController = TextEditingController();
  final cpfController = TextEditingController();
  final dateTimeController = TextEditingController();
  final cepController = TextEditingController();
  final cidadeController = TextEditingController();
  final estadoController = TextEditingController();
  final ruaController = TextEditingController();
  final bairroController = TextEditingController();
  final senhaController = TextEditingController();
  final senhaConfirmarController = TextEditingController();

  @override
  void dispose() {
    widget._cadastrarUsuarioBloc.close();
    nomeController.dispose();
    emailController.dispose();
    telefoneController.dispose();
    cpfController.dispose();
    dateTimeController.dispose();
    cepController.dispose();
    cidadeController.dispose();
    estadoController.dispose();
    ruaController.dispose();
    bairroController.dispose();
    senhaController.dispose();
    senhaConfirmarController.dispose();
    super.dispose();
  }

  String? dropDownGeneroValue;
  final dropDownGeneroItems = [
    'Masculino',
    'Feminino',
    'Outros',
    'Prefiro não identificar'
  ];
  String? dropDownTipoValue;
  final dropDownTipoItems = ['Sou aluno(a)', 'Sou instrutor(a)'];


  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: BlocListener<CadastrarUsuarioBloc, ICadastrarUsuarioBlocState>(
          bloc: widget._cadastrarUsuarioBloc,
          listener: (context, state) async {
            if (state is CadastrarUsuarioBlocStateSucess) {
              await Future.delayed(const Duration(milliseconds: 0));
              Modular.to.pop('/cadastrarUsuarioPage/');
              showDialog(context: context, builder: (_) => const CadastroRealizadoPopupWidget());
            }
            if (state is CadastrarUsuarioBlocStateLoading) {
              showDialog(
                context: context,
                builder: (_) => Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Center(child: CircularProgressIndicator()),
                  ],
                ),
              );
            }

            if (state is CadastrarUsuarioBlocStateError) {
              await Future.delayed(const Duration(milliseconds: 0));
              Modular.to.pop('/cadastrarUsuarioPage/');
              showDialog(
                context: context,
                builder: (_) => const ErroNoServidorPopUpWidget(),
              );
            }
          },
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: 700,
                      minWidth: 200,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)
                            ),
                            elevation: cardElevation,
                            child: Padding(
                              padding: EdgeInsets.only(left: sizesForTextFields.sizePaddingHorizontal, right: sizesForTextFields.sizePaddingHorizontal),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Dados pessoais',
                                    style: TextStyle(color: Theme.of(context).colorScheme.onPrimaryContainer, fontSize: 18),
                                  ),
                                  SizedBox(
                                    height: espacoEntreInputs,
                                  ),
                                  DropdownButtonFormField(
                                    decoration: const InputDecoration(
                                      prefixIcon: Icon(Icons.supervisor_account),
                                      border: OutlineInputBorder(),
                                      hintText: 'Selecionar tipo de conta',
                                      labelText: 'Tipo *',
                                    ),
                                    value: dropDownTipoValue,
                                    items: const [
                                      DropdownMenuItem(value: "ALUNO", child: Text("Sou aluno(a)")),
                                      DropdownMenuItem(value: "INSTRUTOR", child: Text("Sou instrutor(a)")),
                                    ],
                                    onChanged: (String? value) {
                                      setState(() => dropDownTipoValue = value.toString());
                                    },
                                    validator: (String? value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Campo obrigatório';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: espacoEntreInputs,
                                  ),
                                  TextFormField(
                                    autovalidateMode: AutovalidateMode.onUserInteraction,
                                    textCapitalization: TextCapitalization.words,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(RegExp("[A-Za-záàâãéèêíïóôõöúçñÁÀÂÃÉÈÍÏÓÔÕÖÚÇÑ'´` ]")),
                                    ],
                                    keyboardType: TextInputType.name,
                                    controller: nomeController,
                                    decoration: const InputDecoration(
                                      prefixIcon: Icon(Icons.person),
                                      border: OutlineInputBorder(),
                                      hintText: 'Inserir nome completo',
                                      labelText: 'Nome *',
                                    ),
                                    validator: (String? value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Campo obrigatório';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: espacoEntreInputs,
                                  ),
                                  TextFormField(
                                    autovalidateMode: AutovalidateMode.onUserInteraction,
                                    controller: emailController,
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: const InputDecoration(
                                      prefixIcon: Icon(Icons.email),
                                      border: OutlineInputBorder(),
                                      hintText: 'Inserir email válido',
                                      labelText: 'Email *',
                                    ),
                                    validator: (String? value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Campo obrigatório';
                                      }
                                      if (!(RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value))) {
                                        return 'Email inválido';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: espacoEntreInputs,
                                  ),
                                  TextFormField(
                                    autovalidateMode: AutovalidateMode.onUserInteraction,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                      TelefoneInputFormatter(),
                                    ],
                                    controller: telefoneController,
                                    keyboardType: TextInputType.phone,
                                    decoration: const InputDecoration(
                                      prefixIcon: Icon(Icons.phone),
                                      border: OutlineInputBorder(),
                                      hintText: 'Inserir telefone completo',
                                      labelText: 'Telefone *',
                                    ),
                                    validator: (String? value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Campo obrigatório';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: espacoEntreInputs,
                                  ),
                                  TextFormField(
                                    autovalidateMode: AutovalidateMode.onUserInteraction,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                      CpfInputFormatter(),
                                    ],
                                    controller: cpfController,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                      prefixIcon: Icon(Icons.perm_identity),
                                      border: OutlineInputBorder(),
                                      hintText: 'Inserir CPF',
                                      labelText: 'CPF *',
                                    ),
                                    validator: (String? value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Campo obrigatório';
                                      }
                                      if (!(UtilBrasilFields.isCPFValido(value))) {
                                        return 'CPF inválido';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: espacoEntreInputs,
                                  ),
                                  DropdownButtonFormField(
                                    decoration: const InputDecoration(
                                      prefixIcon: Icon(Icons.biotech),
                                      border: OutlineInputBorder(),
                                      hintText: 'Selecionar gênero',
                                      labelText: 'Gênero *',
                                    ),
                                    value: dropDownGeneroValue,
                                    items: const [
                                      DropdownMenuItem(value: 'MASCULINO', child: Text("Masculino")),
                                      DropdownMenuItem(value: 'FEMININO', child: Text("Feminino")),
                                      DropdownMenuItem(value: 'OUTROS', child: Text("Outros")),
                                      DropdownMenuItem(value: 'NAO_IDENTIFICADO', child: Text("Prefiro não identificar")),
                                    ],
                                    onChanged: (String? value) {
                                      setState(() => dropDownGeneroValue = value);
                                    },
                                    validator: (String? value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Campo obrigatório';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: espacoEntreInputs,
                                  ),
                                  TextFormField(
                                    autovalidateMode: AutovalidateMode.onUserInteraction,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                      DataInputFormatter(),
                                    ],
                                    keyboardType: TextInputType.none,
                                    controller: dateTimeController,
                                    onTap: () {
                                      showDatePicker(context: context, initialDate: DateTime(2000), firstDate: DateTime(1900), lastDate: DateTime(DateTime.now().year)).then((value) {
                                        dateTimeController.text = DateFormat('dd/MM/yyyy').format(value!);
                                      });
                                    },
                                    decoration: const InputDecoration(
                                      prefixIcon: Icon(Icons.date_range),
                                      border: OutlineInputBorder(),
                                      hintText: 'Selecionar data de nascimento',
                                      labelText: 'Data de nascimento *',
                                    ),
                                    validator: (String? value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Campo obrigatório';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: espacoEntreCards,),
                          Card(
                            elevation: cardElevation,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: sizesForTextFields.sizePaddingHorizontal,
                              ),
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Endereço',
                                    style: TextStyle(color: Theme.of(context).colorScheme.onPrimaryContainer, fontSize: 18),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  TextFormField(
                                    autovalidateMode: AutovalidateMode.onUserInteraction,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                      CepInputFormatter(),
                                    ],
                                    controller: cepController,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                      prefixIcon: Icon(Icons.location_on),
                                      border: OutlineInputBorder(),
                                      hintText: 'Inserir CEP da cidade',
                                      labelText: 'CEP *',
                                    ),
                                    validator: (String? value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Campo obrigatório';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: espacoEntreInputs,
                                  ),
                                  TextFormField(
                                    autovalidateMode: AutovalidateMode.onUserInteraction,
                                    textCapitalization: TextCapitalization.words,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(RegExp("[a-z A-Z]")),
                                    ],
                                    controller: cidadeController,
                                    keyboardType: TextInputType.name,
                                    decoration: const InputDecoration(
                                      prefixIcon: Icon(Icons.location_city),
                                      border: OutlineInputBorder(),
                                      hintText: 'Inserir nome da cidade',
                                      labelText: 'Cidade *',
                                    ),
                                    validator: (String? value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Campo obrigatório';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: espacoEntreInputs,
                                  ),
                                  TextFormField(
                                    autovalidateMode: AutovalidateMode.onUserInteraction,
                                    textCapitalization: TextCapitalization.characters,
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(2),
                                      FilteringTextInputFormatter.allow(RegExp("[a-z A-Z]")),
                                    ],
                                    controller: estadoController,
                                    keyboardType: TextInputType.name,
                                    decoration: const InputDecoration(
                                      prefixIcon: Icon(Icons.my_location_outlined),
                                      border: OutlineInputBorder(),
                                      hintText: 'Inserir estado da cidade (sigla)',
                                      labelText: 'Estado *',
                                    ),
                                    validator: (String? value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Campo obrigatório';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: espacoEntreInputs,
                                  ),
                                  TextFormField(
                                    autovalidateMode: AutovalidateMode.onUserInteraction,
                                    textCapitalization: TextCapitalization.words,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(RegExp("[a-z A-Z]")),
                                    ],
                                    controller: ruaController,
                                    keyboardType: TextInputType.name,
                                    decoration: const InputDecoration(
                                      prefixIcon: Icon(Icons.route),
                                      border: OutlineInputBorder(),
                                      hintText: 'Inserir nome da rua',
                                      labelText: 'Rua *',
                                    ),
                                    validator: (String? value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Campo obrigatório';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: espacoEntreInputs,
                                  ),
                                  TextFormField(
                                    autovalidateMode: AutovalidateMode.onUserInteraction,
                                    textCapitalization: TextCapitalization.words,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(RegExp("[a-z A-Z]")),
                                    ],
                                    controller: bairroController,
                                    keyboardType: TextInputType.name,
                                    decoration: const InputDecoration(
                                      prefixIcon: Icon(Icons.other_houses),
                                      border: OutlineInputBorder(),
                                      hintText: 'Inserir bairro da casa',
                                      labelText: 'Bairro *',
                                    ),
                                    validator: (String? value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Campo obrigatório';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: espacoEntreCards,),
                          Card(
                            elevation: cardElevation,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: sizesForTextFields.sizePaddingHorizontal),
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Segurança',
                                    style: TextStyle(color: Theme.of(context).colorScheme.onPrimaryContainer, fontSize: 18),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  TextFormField(
                                    autovalidateMode: AutovalidateMode.onUserInteraction,
                                    obscureText: true,
                                    controller: senhaController,
                                    decoration: const InputDecoration(
                                      prefixIcon: Icon(Icons.password),
                                      border: OutlineInputBorder(),
                                      hintText: 'Inserir senha',
                                      labelText: 'Senha *',
                                    ),
                                    validator: (String? value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Campo obrigatório';
                                      }
                                      if (!regex.hasMatch(value)) {
                                        return 'Minimo 8 caracteres e números';
                                      }
                                      if (senhaController.text != senhaConfirmarController.text) {
                                        return 'Senhas devem ser iguais nos dois campos';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: espacoEntreInputs,
                                  ),
                                  TextFormField(
                                    autovalidateMode: AutovalidateMode.onUserInteraction,
                                    obscureText: true,
                                    controller: senhaConfirmarController,
                                    decoration: const InputDecoration(
                                      prefixIcon: Icon(Icons.password),
                                      border: OutlineInputBorder(),
                                      hintText: 'Inserir senha novamente',
                                      labelText: 'Confirmar senha *',
                                    ),
                                    validator: (String? value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Campo obrigatório';
                                      }
                                      if (!regex.hasMatch(value)) {
                                        return 'Minimo 8 caracteres e números';
                                      }
                                      if (senhaController.text != senhaConfirmarController.text) {
                                        return 'Senhas devem ser iguais nos dois campos';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Theme.of(context).colorScheme.primary
                            ),
                            onPressed: () async {
                              bool cadastroValidado = formKey.currentState!.validate();
                              if (cadastroValidado) {
                                EnderecoEntity enderecoEntity =
                                EnderecoEntity(cep: cepController.text, cidade: cidadeController.text, estado: estadoController.text, rua: ruaController.text, bairro: bairroController.text);
                                UsuarioEntity usuarioEntity = UsuarioEntity(
                                    nome: nomeController.text,
                                    cpf: cpfController.text,
                                    dataNascimento: dateTimeController.text,
                                    genero: dropDownGeneroValue!,
                                    email: emailController.text,
                                    senha: senhaController.text,
                                    telefone: telefoneController.text,
                                    endereco: enderecoEntity,
                                    tipoUsuario: dropDownTipoValue!);
                                if (widget._cadastrarUsuarioBloc.state is CadastrarUsuarioBlocStateError) {
                                  await Future.delayed(const Duration(seconds: 1));
                                }
                                widget._cadastrarUsuarioBloc.add(CadastrarUsuarioBlocEventSalvarCadastro(usuarioEntity));
                              }
                            },
                            child: Text('Confirmar cadastro', style: TextStyle(
                                color: Theme.of(context).colorScheme.background
                            ),),
                          ),
                          const SizedBox(height: 20,)
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}