

import '../../../domain/errors/i_erro_salvar_cadastro_usuario.dart';
import 'i_cadastrar_usuario_bloc_state.dart';

class CadastrarUsuarioBlocStateError extends ICadastrarUsuarioBlocState{
 IErroSalvarCadastroUsuario iErroSalvarCadastroUsuario;

 CadastrarUsuarioBlocStateError({
    required this.iErroSalvarCadastroUsuario,
  });
}