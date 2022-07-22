import '../../domain/entities/endereco_entity.dart';
import '../dto/endereco_dto.dart';
import 'i_endereco_mapper.dart';

class EnderecoMapperImpl implements IEnderecoMapper{
  @override
  EnderecoDto toEnderecoDto(EnderecoEntity enderecoEntity) {

    return EnderecoDto(
        cep: enderecoEntity.cep,
        cidade: enderecoEntity.cidade,
        estado: enderecoEntity.estado,
        rua: enderecoEntity.rua,
        bairro: enderecoEntity.bairro);

  }

}