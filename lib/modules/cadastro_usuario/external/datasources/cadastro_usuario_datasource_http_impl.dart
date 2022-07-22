import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../domain/errors/erro_salvar_cadastro_usuario_datasource.dart';
import '../../infra/datasources/i_cadastro_usuario_datasource.dart';
import '../../infra/dto/usuario_create_dto.dart';
import 'extract_id_from_header.dart';

class CadastroUsuarioDatasourceHttpImpl implements ICadastroUsuarioDatasource {
  final String _urlBase =
      const String.fromEnvironment('URLBASE', defaultValue: 'teste');
  final String _urlEndPoint = '/api/v1/usuarios';
  final http.Client clientHttp;
  final ExtractIdFromHeader extractIdFromHeader;
  final Map<String, String> header = {
    'Content-Type': 'application/json'
  };

  @override
  Future<int> salvarCadastroUsuario(UsuarioCreateDto usuarioCreateDto) async {
    final http.Response response = await clientHttp.post(Uri.parse(_urlBase + _urlEndPoint), body: jsonEncode(usuarioCreateDto.toMap()), headers: header);
    if (response.statusCode == 201) {
      return extractIdFromHeader(response.headers['location']!);
    } else {
      throw ErroSalvarCadastroUsuarioDatasource();
    }
  }

   CadastroUsuarioDatasourceHttpImpl({
    required this.clientHttp,
    required this.extractIdFromHeader,
  });
}
