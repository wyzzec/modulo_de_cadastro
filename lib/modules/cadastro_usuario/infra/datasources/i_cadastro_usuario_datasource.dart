



import '../dto/usuario_create_dto.dart';

abstract class ICadastroUsuarioDatasource {
  Future<int> salvarCadastroUsuario(UsuarioCreateDto usuarioCreateDto);
}