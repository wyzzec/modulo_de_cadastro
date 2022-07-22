import 'package:bloc/bloc.dart';
import '../../domain/usecases/i_salvar_cadastro_usuario_usecase.dart';
import 'cadastrar_usuario_bloc_events/cadastrar_usuario_bloc_event_salvar_cadastro.dart';
import 'cadastrar_usuario_bloc_events/i_cadastrar_usuario_bloc_event.dart';
import 'cadastrar_usuario_bloc_states/cadastrar_usuario_bloc_state_error.dart';
import 'cadastrar_usuario_bloc_states/cadastrar_usuario_bloc_state_initial.dart';
import 'cadastrar_usuario_bloc_states/cadastrar_usuario_bloc_state_loading.dart';
import 'cadastrar_usuario_bloc_states/cadastrar_usuario_bloc_state_sucess.dart';
import 'cadastrar_usuario_bloc_states/i_cadastrar_usuario_bloc_state.dart';


class CadastrarUsuarioBloc extends Bloc<ICadastrarUsuarioBlocEvent, ICadastrarUsuarioBlocState> {
  CadastrarUsuarioBloc({required ISalvarUsuarioUseCase iSalvarUsuarioUseCase}) : _iSalvarUsuarioUseCase = iSalvarUsuarioUseCase, super(CadastrarUsuarioBlocStateInitial()) {
    on<CadastrarUsuarioBlocEventSalvarCadastro>(
        (event, emit) async {
          emit(CadastrarUsuarioBlocStateLoading());
          final result = await _iSalvarUsuarioUseCase.call(event.usuarioEntity);
          result.fold((l) => emit(CadastrarUsuarioBlocStateError(iErroSalvarCadastroUsuario: l)), (r) => emit(CadastrarUsuarioBlocStateSucess(idAluno: r)));
        }
    );
  }


  final ISalvarUsuarioUseCase _iSalvarUsuarioUseCase;

}
