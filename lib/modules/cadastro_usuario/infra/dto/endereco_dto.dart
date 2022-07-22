

class EnderecoDto {
  final String _cep;
  final String _cidade;
  final String _estado;
  final String _rua;
  final String _bairro;

//<editor-fold desc="Data Methods">


  const EnderecoDto({
    required String cep,
    required String cidade,
    required String estado,
    required String rua,
    required String bairro,
  })
      : _cep = cep,
        _cidade = cidade,
        _estado = estado,
        _rua = rua,
        _bairro = bairro;


  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          (other is EnderecoDto &&
              runtimeType == other.runtimeType &&
              _cep == other._cep &&
              _cidade == other._cidade &&
              _estado == other._estado &&
              _rua == other._rua &&
              _bairro == other._bairro
          );


  @override
  int get hashCode =>
      _cep.hashCode ^
      _cidade.hashCode ^
      _estado.hashCode ^
      _rua.hashCode ^
      _bairro.hashCode;


  @override
  String toString() {
    return 'EnderecoDto{ cep: $_cep, cidade: $_cidade, estado: $_estado, rua: $_rua, bairro: $_bairro,}';
  }


  EnderecoDto copyWith({
    String? cep,
    String? cidade,
    String? estado,
    String? rua,
    String? bairro,
  }) {
    return EnderecoDto(
      cep: cep ?? _cep,
      cidade: cidade ?? _cidade,
      estado: estado ?? _estado,
      rua: rua ?? _rua,
      bairro: bairro ?? _bairro,
    );
  }


  Map<String, dynamic> toMap() {
    return {
      'cep': _cep,
      'cidade': _cidade,
      'estado': _estado,
      'rua': _rua,
      'bairro': _bairro,
    };
  }

  factory EnderecoDto.fromMap(Map<String, dynamic> map) {
    return EnderecoDto(
      cep: map['cep'] as String,
      cidade: map['cidade'] as String,
      estado: map['estado'] as String,
      rua: map['rua'] as String,
      bairro: map['bairro'] as String,
    );
  }


//</editor-fold>
}