import 'package:dartz/dartz.dart';
import '../entities/usuario_entity.dart';
import '../errors/i_erro_salvar_cadastro_usuario.dart';

abstract class ICadastroUsuarioRepository{
  Future<Either<IErroSalvarCadastroUsuario, int>> salvarCadastroUsuario(UsuarioEntity usuarioEntity);
}