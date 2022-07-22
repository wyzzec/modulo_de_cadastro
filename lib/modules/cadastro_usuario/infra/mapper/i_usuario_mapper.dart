import '../../domain/entities/usuario_entity.dart';
import '../dto/usuario_create_dto.dart';

abstract class IUsuarioMapper{

  UsuarioCreateDto toUsuarioCreateDto (UsuarioEntity usuarioEntity);

}