import '../../../cadastro_usuario/domain/errors/i_erro_salvar_cadastro_usuario.dart';

class ErroSalvarCadastroUsuarioDatasource implements IErroSalvarCadastroUsuario {
  String? message;

  ErroSalvarCadastroUsuarioDatasource({
    this.message,
  });
}