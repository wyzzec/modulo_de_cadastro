
import 'package:dartz/dartz.dart';

import '../../../cadastro_usuario/domain/entities/usuario_entity.dart';
import '../../../cadastro_usuario/domain/errors/i_erro_salvar_cadastro_usuario.dart';

abstract class ISalvarUsuarioUseCase{
  Future<Either<IErroSalvarCadastroUsuario, int>> call(UsuarioEntity usuarioEntity);
}