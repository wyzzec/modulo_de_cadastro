import '../../../domain/entities/usuario_entity.dart';
import 'i_cadastrar_usuario_bloc_event.dart';

class CadastrarUsuarioBlocEventSalvarCadastro extends ICadastrarUsuarioBlocEvent{
  UsuarioEntity usuarioEntity;

  CadastrarUsuarioBlocEventSalvarCadastro(this.usuarioEntity);
}
