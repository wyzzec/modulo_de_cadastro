

import 'endereco_dto.dart';

class UsuarioCreateDto {
  final String _nome;
  final String _cpf;
  final String _dataNascimento;
  final String _genero;
  final String _email;
  final String _senha;
  final String _telefone;
  final EnderecoDto _endereco;
  final String _tipoUsuario;

//<editor-fold desc="Data Methods">

  const UsuarioCreateDto({
    required String nome,
    required String cpf,
    required String dataNascimento,
    required String genero,
    required String email,
    required String senha,
    required String telefone,
    required EnderecoDto endereco,
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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UsuarioCreateDto &&
          runtimeType == other.runtimeType &&
          _nome == other._nome &&
          _cpf == other._cpf &&
          _dataNascimento == other._dataNascimento &&
          _genero == other._genero &&
          _email == other._email &&
          _senha == other._senha &&
          _telefone == other._telefone &&
          _endereco == other._endereco &&
          _tipoUsuario == other._tipoUsuario);

  @override
  int get hashCode =>
      _nome.hashCode ^
      _cpf.hashCode ^
      _dataNascimento.hashCode ^
      _genero.hashCode ^
      _email.hashCode ^
      _senha.hashCode ^
      _telefone.hashCode ^
      _endereco.hashCode ^
      _tipoUsuario.hashCode;

  @override
  String toString() {
    return 'UsuarioCreateDto{ nome: $_nome, _cpf: $_cpf, dataNascimento: $_dataNascimento, genero: $_genero, email: $_email, senha: $_senha, telefone: $_telefone, endereco: $_endereco, tipoUsuario: $_tipoUsuario,}';
  }

  UsuarioCreateDto copyWith({
    String? nome,
    String? cpf,
    String? dataNascimento,
    String? genero,
    String? email,
    String? senha,
    String? telefone,
    EnderecoDto? endereco,
    String? tipoUsuario,
  }) {
    return UsuarioCreateDto(
      nome: nome ?? _nome,
      cpf: cpf ?? _cpf,
      dataNascimento: dataNascimento ?? _dataNascimento,
      genero: genero ?? _genero,
      email: email ?? _email,
      senha: senha ?? _senha,
      telefone: telefone ?? _telefone,
      endereco: endereco ?? _endereco,
      tipoUsuario: tipoUsuario ?? _tipoUsuario,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nome': _nome,
      'cpf': _cpf,
      'dataNascimento': _dataNascimento,
      'genero': _genero,
      'email': _email,
      'senha': _senha,
      'telefone': _telefone,
      'endereco': _endereco.toMap(),
      'tipoUsuario': _tipoUsuario,
    };
  }

  factory UsuarioCreateDto.fromMap(Map<String, dynamic> map) {
    return UsuarioCreateDto(
      nome: map['nome'] as String,
      cpf: map['cpf'] as String,
      dataNascimento: map['dataNascimento'] as String,
      genero: map['genero'] as String,
      email: map['email'] as String,
      senha: map['senha'] as String,
      telefone: map['telefone'] as String,
      endereco: EnderecoDto.fromMap(map['endereco']),
      tipoUsuario: map['tipoUsuario'] as String,
    );
  }

//</editor-fold>
}
