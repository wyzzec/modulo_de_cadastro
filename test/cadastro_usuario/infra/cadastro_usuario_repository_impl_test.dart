import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:dartz/dartz.dart';
import 'package:modulo_de_cadastro/modules/cadastro_usuario/domain/entities/endereco_entity.dart';
import 'package:modulo_de_cadastro/modules/cadastro_usuario/domain/entities/usuario_entity.dart';
import 'package:modulo_de_cadastro/modules/cadastro_usuario/domain/errors/erro_salvar_cadastro_usuario_datasource.dart';
import 'package:modulo_de_cadastro/modules/cadastro_usuario/infra/datasources/i_cadastro_usuario_datasource.dart';
import 'package:modulo_de_cadastro/modules/cadastro_usuario/infra/dto/usuario_create_dto.dart';
import 'package:modulo_de_cadastro/modules/cadastro_usuario/infra/mapper/endereco_mapper_impl.dart';
import 'package:modulo_de_cadastro/modules/cadastro_usuario/infra/mapper/usuario_mapper_impl.dart';
import 'package:modulo_de_cadastro/modules/cadastro_usuario/infra/repositories/cadastro_usuario_repository_impl.dart';

class CadastroUsuarioDatasourceMock extends Mock implements ICadastroUsuarioDatasource{}


main(){
  const EnderecoEntity enderecoEntity = EnderecoEntity(
      cep: 'cep',
      cidade: 'cidade',
      estado: 'estado',
      rua: 'rua',
      bairro: 'bairro');
  const UsuarioEntity usuarioEntity = UsuarioEntity(
      nome: 'gustavo',
      cpf: '123',
      dataNascimento: '1997-05-07',
      genero: 'a',
      email: 'email@corno.com',
      senha: 'senha',
      telefone: 'telefone',
      endereco: enderecoEntity,
      tipoUsuario: 'INSTRUTOR');



  final datasource = CadastroUsuarioDatasourceMock();
  EnderecoMapperImpl enderecoMapperImpl = EnderecoMapperImpl();
  UsuarioMapperImpl usuarioMapperImpl = UsuarioMapperImpl(iEnderecoMapper: enderecoMapperImpl);
  UsuarioCreateDto usuarioCreateDto = usuarioMapperImpl.toUsuarioCreateDto(usuarioEntity);
  final repository = CadastroUsuarioRepositoryImpl(iCadastroUsuarioDatasource: datasource, iUsuarioMapper: usuarioMapperImpl);

  test ('deve retornar um ID de usuario caso o cadastro seja bem sucedido',() async {
    when(() => datasource.salvarCadastroUsuario(usuarioCreateDto)).thenAnswer((_) async => 2);
    
    final result = await repository.salvarCadastroUsuario(usuarioEntity);
    expect(result, isA<Right>());
    expect(result.fold(id, id), equals(2));

  });

  test ('deve retornar um ErroSalvarCadastroUsuarioRepository',() async {
    when(() => datasource.salvarCadastroUsuario(usuarioCreateDto)).thenThrow(Exception());

    final result = await repository.salvarCadastroUsuario(usuarioEntity);

    expect(result.fold(id, id), isA<ErroSalvarCadastroUsuarioDatasource>());
  });
}