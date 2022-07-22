import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:modulo_de_cadastro/modules/cadastro_usuario/domain/entities/endereco_entity.dart';
import 'package:modulo_de_cadastro/modules/cadastro_usuario/domain/entities/usuario_entity.dart';
import 'package:modulo_de_cadastro/modules/cadastro_usuario/domain/errors/erro_salvar_cadastro_usuario_datasource.dart';
import 'package:modulo_de_cadastro/modules/cadastro_usuario/domain/usecases/i_salvar_cadastro_usuario_usecase.dart';
import 'package:modulo_de_cadastro/modules/cadastro_usuario/presenter/bloc/cadastrar_usuario_bloc.dart';
import 'package:modulo_de_cadastro/modules/cadastro_usuario/presenter/bloc/cadastrar_usuario_bloc_events/cadastrar_usuario_bloc_event_salvar_cadastro.dart';
import 'package:modulo_de_cadastro/modules/cadastro_usuario/presenter/bloc/cadastrar_usuario_bloc_states/cadastrar_usuario_bloc_state_error.dart';
import 'package:modulo_de_cadastro/modules/cadastro_usuario/presenter/bloc/cadastrar_usuario_bloc_states/cadastrar_usuario_bloc_state_initial.dart';
import 'package:modulo_de_cadastro/modules/cadastro_usuario/presenter/bloc/cadastrar_usuario_bloc_states/cadastrar_usuario_bloc_state_sucess.dart';


class SalvarUsuarioUseCaseMock extends Mock implements ISalvarUsuarioUseCase {}

main() {
  final usecase = SalvarUsuarioUseCaseMock();


  const EnderecoEntity enderecoEntity = EnderecoEntity(
      cep: 'cep',
      cidade: 'cidade',
      estado: 'estado',
      rua: 'rua',
      bairro: 'bairro');
  const UsuarioEntity usuarioEntity = UsuarioEntity(
      nome: 'gustavo',
      cpf: '123',
      dataNascimento: '1997/05/07',
      genero: 'a',
      email: 'email@corno.com',
      senha: 'senha',
      telefone: 'telefone',
      endereco: enderecoEntity,
      tipoUsuario: 'INSTRUTOR');




  group('teste bloc', () {

    test('deve emitir a ordem correta da stream', () async {
      CadastrarUsuarioBloc bloc = CadastrarUsuarioBloc(iSalvarUsuarioUseCase: usecase,);
      when(() => usecase.call(usuarioEntity)).thenAnswer((_) async => Right(2));

      expect(bloc.state, isA<CadastrarUsuarioBlocStateInitial>());
      bloc.add(CadastrarUsuarioBlocEventSalvarCadastro(usuarioEntity));
      await Future.delayed(Duration(seconds: 0));
      expect(bloc.state, isA<CadastrarUsuarioBlocStateSucess>());
      var state = bloc.state as CadastrarUsuarioBlocStateSucess;
      expect(state.idAluno, 2);
      bloc.close();
    });
    test('deve emitir a ordem correta da stream', () async {
      CadastrarUsuarioBloc bloc = CadastrarUsuarioBloc(iSalvarUsuarioUseCase: usecase,);
      when(() => usecase.call(usuarioEntity)).thenAnswer((_) async => Left(ErroSalvarCadastroUsuarioDatasource()));
      expect(bloc.state, isA<CadastrarUsuarioBlocStateInitial>());
      bloc.add(CadastrarUsuarioBlocEventSalvarCadastro(usuarioEntity));
      await Future.delayed(Duration(seconds: 0));
      expect(bloc.state, isA<CadastrarUsuarioBlocStateError>());
      var state = bloc.state as CadastrarUsuarioBlocStateError;
      expect(state.iErroSalvarCadastroUsuario, isA<ErroSalvarCadastroUsuarioDatasource>());
      bloc.close();
    });
  });
}
