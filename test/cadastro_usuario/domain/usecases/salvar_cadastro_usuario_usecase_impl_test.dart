import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:modulo_de_cadastro/modules/cadastro_usuario/domain/entities/endereco_entity.dart';
import 'package:modulo_de_cadastro/modules/cadastro_usuario/domain/entities/usuario_entity.dart';
import 'package:modulo_de_cadastro/modules/cadastro_usuario/domain/errors/erro_salvar_cadastro_usuario_campo_vazio_impl.dart';
import 'package:modulo_de_cadastro/modules/cadastro_usuario/domain/repositories/i_cadastro_usuario_repository.dart';
import 'package:modulo_de_cadastro/modules/cadastro_usuario/domain/usecases/salvar_cadastro_usuario_usecase_impl.dart';


class CadastroUsuarioRepositoryMock extends Mock
    implements ICadastroUsuarioRepository {}

main() {


  final cadastroUsuarioRepositoryMock = CadastroUsuarioRepositoryMock();
  final salvarCadastroUsuarioUsecaseImpl =
      SalvarCadastroUsuarioUsecaseImpl( iCadastroUsuarioRepository: cadastroUsuarioRepositoryMock,);

  test('deve retornar uma response HTTP 200 caso tenha sucesso em registrar',
      () async {

        const EnderecoEntity enderecoEntity = EnderecoEntity(
            cep: 'cep',
            cidade: 'cidade',
            estado: 'estado',
            rua: 'rua',
            bairro: 'bairro');
        final UsuarioEntity usuarioEntity = UsuarioEntity(
            nome: 'gustavo',
            cpf: '123',
            dataNascimento: DateTime.now().toIso8601String(),
            genero: 'a',
            email: 'email@corno.com',
            senha: 'senha',
            telefone: 'telefone',
            endereco: enderecoEntity,
            tipoUsuario: 'INSTRUTOR');

    when(() =>
            cadastroUsuarioRepositoryMock.salvarCadastroUsuario(usuarioEntity))
        .thenAnswer((_) async => Right(2));

    final result = await salvarCadastroUsuarioUsecaseImpl(usuarioEntity);

    expect(result, isA<Right>());
    expect(result.fold(id, id), equals(2));
  });

  test('deve retornar um erro de campo vazio', () async {

    const EnderecoEntity enderecoEntity = EnderecoEntity(
        cep: '',
        cidade: 'cidade',
        estado: 'estado',
        rua: 'rua',
        bairro: 'bairro');
    const UsuarioEntity usuarioEntity = UsuarioEntity(
        nome: '',
        cpf: '123',
        dataNascimento: '1997/05/07',
        genero: '',
        email: '',
        senha: '',
        telefone: 'telefone',
        endereco: enderecoEntity,
        tipoUsuario: 'INSTRUTOR');

    when(() =>
        cadastroUsuarioRepositoryMock.salvarCadastroUsuario(usuarioEntity))
        .thenAnswer((_) async => Right(2));

    final result = await salvarCadastroUsuarioUsecaseImpl(usuarioEntity);

    expect(result, isA<Left>());
    expect(result.fold(id, id), isA<ErroSalvarCadastroUsuarioCampoVazioImpl>());
  });
}
