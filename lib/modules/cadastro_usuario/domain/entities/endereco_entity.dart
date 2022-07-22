class EnderecoEntity{
  final String _cep;
  final String _cidade;
  final String _estado;
  final String _rua;
  final String _bairro;

  const EnderecoEntity({
    required String cep,
    required String cidade,
    required String estado,
    required String rua,
    required String bairro,
  })  : _cep = cep,
        _cidade = cidade,
        _estado = estado,
        _rua = rua,
        _bairro = bairro;

  String get cep => _cep;

  String get bairro => _bairro;

  String get rua => _rua;

  String get estado => _estado;

  String get cidade => _cidade;

}