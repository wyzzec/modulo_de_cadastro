import 'dart:convert';

import 'package:dartz/dartz.dart' as dartz;
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:modular_test/modular_test.dart';

import 'package:http/http.dart' as http;
import 'package:modulo_de_cadastro/modules/cadastro_usuario/cadastro_usuario_module.dart';
import 'package:modulo_de_cadastro/modules/cadastro_usuario/domain/entities/endereco_entity.dart';
import 'package:modulo_de_cadastro/modules/cadastro_usuario/domain/entities/usuario_entity.dart';
import 'package:modulo_de_cadastro/modules/cadastro_usuario/domain/usecases/i_salvar_cadastro_usuario_usecase.dart';
import 'package:modulo_de_cadastro/modules/cadastro_usuario/domain/usecases/salvar_cadastro_usuario_usecase_impl.dart';
import 'package:modulo_de_cadastro/modules/cadastro_usuario/infra/mapper/i_usuario_mapper.dart';


class HttpMock extends Mock implements http.Client{

}


void main (){
  final HttpMock httpMock = HttpMock();
  initModule(CadastroModule(),
      replaceBinds: [
        Bind.instance<http.Client>(httpMock),
      ]);

  final Map<String, String> headerPost = {
    'Content-Type': 'application/json'
  };


  test('deve retornar o usecase através do sistema de injeção de dependencia', () {

    final usecase = Modular.get<ISalvarUsuarioUseCase>();

    expect(usecase, isA<SalvarCadastroUsuarioUsecaseImpl>());

  });

  test('deve retornar o ID do usuario cadastrado', () async {

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

    Map<String, String> header = {'location':'http://apidomain.com/v1/usuarios/2'};
    final httpResponse201 = http.Response('{test:test}', 201, headers: header);

    final usuarioMapper = Modular.get<IUsuarioMapper>();
    final usuarioCreateDto = usuarioMapper.toUsuarioCreateDto(usuarioEntity);

    when(() => httpMock.post(Uri.parse('teste/api/v1/usuarios'),
        body: jsonEncode(usuarioCreateDto.toMap()), headers: headerPost))
        .thenAnswer((_) async => httpResponse201);

    final usecase = Modular.get<ISalvarUsuarioUseCase>();
    final result = await usecase.call(usuarioEntity);
    expect(result.fold(dartz.id, dartz.id), isA<int>());
  });
}