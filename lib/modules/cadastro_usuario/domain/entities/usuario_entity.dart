

import '../../../cadastro_usuario/domain/entities/endereco_entity.dart';

class UsuarioEntity{
  final String _nome;
  final String _cpf;
  final String _dataNascimento;
  final String _genero;
  final String _email;
  final String _senha;
  final String _telefone;
  final EnderecoEntity _endereco;
  final String _tipoUsuario;

  const UsuarioEntity({
    required String nome,
    required String cpf,
    required String dataNascimento,
    required String genero,
    required String email,
    required String senha,
    required String telefone,
    required EnderecoEntity endereco,
    required String tipoUsuario,
  })  : _nome = nome,
        _cpf = cpf,
        _dataNascimento = dataNascimento,
        _genero = genero,
        _email = email,
        _senha = senha,
        _telefone = telefone,
        _endereco = endereco,
        _tipoUsuario = tipoUsuario;

  String get nome => _nome;

  String get tipoUsuario => _tipoUsuario;

  EnderecoEntity get endereco => _endereco;

  String get telefone => _telefone;

  String get senha => _senha;

  String get email => _email;

  String get genero => _genero;

  String get dataNascimento => _dataNascimento;

  String get cpf => _cpf;
}