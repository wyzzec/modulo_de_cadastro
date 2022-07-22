import 'package:dartz/dartz.dart';
import '../../../cadastro_usuario/domain/entities/usuario_entity.dart';
import '../../../cadastro_usuario/domain/errors/i_erro_salvar_cadastro_usuario.dart';
import '../../../cadastro_usuario/domain/usecases/i_salvar_cadastro_usuario_usecase.dart';
import '../errors/erro_salvar_cadastro_usuario_campo_vazio_impl.dart';
import '../repositories/i_cadastro_usuario_repository.dart';

class SalvarCadastroUsuarioUsecaseImpl implements ISalvarUsuarioUseCase {

  final ICadastroUsuarioRepository _iCadastroUsuarioRepository;

  @override
  Future<Either<IErroSalvarCadastroUsuario, int>> call(
      UsuarioEntity usuarioEntity) async {
    if (usuarioEntity.nome.isEmpty ||
        usuarioEntity.cpf.toString().isEmpty ||
        usuarioEntity.dataNascimento.toString().isEmpty ||
        usuarioEntity.email.isEmpty ||
        usuarioEntity.endereco.cep.isEmpty ||
        usuarioEntity.endereco.rua.isEmpty ||
        usuarioEntity.genero.toString().isEmpty ||
        usuarioEntity.senha.isEmpty ||
        usuarioEntity.telefone.isEmpty) {
      return Left(ErroSalvarCadastroUsuarioCampoVazioImpl());
    }

    return _iCadastroUsuarioRepository.salvarCadastroUsuario(usuarioEntity);
  }

  const SalvarCadastroUsuarioUsecaseImpl({
    required ICadastroUsuarioRepository iCadastroUsuarioRepository,
  }) : _iCadastroUsuarioRepository = iCadastroUsuarioRepository;
}
