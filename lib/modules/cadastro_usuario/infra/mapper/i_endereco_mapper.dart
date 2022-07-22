import '../../domain/entities/endereco_entity.dart';
import '../dto/endereco_dto.dart';

abstract class IEnderecoMapper {

  EnderecoDto toEnderecoDto (EnderecoEntity enderecoEntity);

}