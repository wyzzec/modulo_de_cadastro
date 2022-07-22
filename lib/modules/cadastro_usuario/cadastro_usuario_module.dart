import 'package:flutter_modular/flutter_modular.dart';
import 'package:http/http.dart' as http;
import 'package:modulo_de_cadastro/modules/cadastro_usuario/presenter/bloc/cadastrar_usuario_bloc.dart';
import 'package:modulo_de_cadastro/modules/cadastro_usuario/presenter/pages/cadastrar_usuario_page.dart';

import 'domain/usecases/salvar_cadastro_usuario_usecase_impl.dart';
import 'external/datasources/cadastro_usuario_datasource_http_impl.dart';
import 'external/datasources/extract_id_from_header.dart';
import 'infra/mapper/endereco_mapper_impl.dart';
import 'infra/mapper/usuario_mapper_impl.dart';
import 'infra/repositories/cadastro_usuario_repository_impl.dart';




class CadastroModule extends Module {
  @override
  final List<Bind> binds = [
    Bind<http.Client>((i) => http.Client()),
    Bind((i) => CadastroUsuarioDatasourceHttpImpl(extractIdFromHeader: i(), clientHttp: i())),
    Bind((i) => ExtractIdFromHeader()),
    Bind((i) => CadastroUsuarioRepositoryImpl(iCadastroUsuarioDatasource: i(), iUsuarioMapper: i())),
    Bind((i) => UsuarioMapperImpl(iEnderecoMapper: i())),
    Bind((i) => EnderecoMapperImpl()),
    Bind((i) => SalvarCadastroUsuarioUsecaseImpl(iCadastroUsuarioRepository: i())),
    Bind((i) => CadastrarUsuarioBloc(iSalvarUsuarioUseCase: i())),
  ];
  @override
  List<ModularRoute> get routes => [
    ChildRoute('/', child: ((context, args) => CadastrarUsuarioPage(cadastrarUsuarioBloc: Modular.get<CadastrarUsuarioBloc>(),))),
  ];
}