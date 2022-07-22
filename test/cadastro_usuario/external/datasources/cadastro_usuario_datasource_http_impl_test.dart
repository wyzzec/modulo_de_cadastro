import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:modulo_de_cadastro/modules/cadastro_usuario/domain/entities/endereco_entity.dart';
import 'package:modulo_de_cadastro/modules/cadastro_usuario/domain/entities/usuario_entity.dart';
import 'package:modulo_de_cadastro/modules/cadastro_usuario/domain/errors/erro_salvar_cadastro_usuario_datasource.dart';
import 'package:modulo_de_cadastro/modules/cadastro_usuario/external/datasources/cadastro_usuario_datasource_http_impl.dart';
import 'package:modulo_de_cadastro/modules/cadastro_usuario/external/datasources/extract_id_from_header.dart';
import 'package:modulo_de_cadastro/modules/cadastro_usuario/infra/dto/usuario_create_dto.dart';
import 'package:modulo_de_cadastro/modules/cadastro_usuario/infra/mapper/endereco_mapper_impl.dart';
import 'package:modulo_de_cadastro/modules/cadastro_usuario/infra/mapper/usuario_mapper_impl.dart';



class HttpMock extends Mock implements http.Client {}

main() {

  Map<String, String> header = {'location':'http://apidomain.com/v1/usuarios/2'};
  final httpMock = HttpMock();
  final ExtractIdFromHeader extractIdFromHeader = ExtractIdFromHeader();
  final datasource = CadastroUsuarioDatasourceHttpImpl(clientHttp: httpMock, extractIdFromHeader: extractIdFromHeader,);
  final httpResponse201 = http.Response('{test:test}', 201, headers: header);
  final httpResponse400 = http.Response('{test:test}', 400);
  final Map<String, String> headerPost = {
    'Content-Type': 'application/json'
  };

  test('deve retornar um id do aluno no header em caso de sucesso ao registrar',
      () async {
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



    UsuarioCreateDto usuarioCreateDto = UsuarioMapperImpl(iEnderecoMapper: EnderecoMapperImpl())
        .toUsuarioCreateDto(usuarioEntity);

    when(() => httpMock.post(Uri.parse('teste/api/v1/usuarios'),
            body: jsonEncode(usuarioCreateDto.toMap()), headers: headerPost))
        .thenAnswer((_) async => httpResponse201);

    final response = await datasource.salvarCadastroUsuario(usuarioCreateDto);

    expect(response, equals(2));
  });

  test('deve retornar um erro se o statuscode não for 201', () async {
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

    UsuarioCreateDto usuarioCreateDto = UsuarioMapperImpl(iEnderecoMapper: EnderecoMapperImpl())
        .toUsuarioCreateDto(usuarioEntity);

    when(() => httpMock.post(Uri.parse('teste/api/v1/usuarios'),
            body: jsonEncode(usuarioCreateDto.toMap()), headers: headerPost))
        .thenAnswer((_) async => httpResponse400);

    final future = datasource.salvarCadastroUsuario(usuarioCreateDto);

    expect(future, throwsA(isA<ErroSalvarCadastroUsuarioDatasource>()));
  });
}
