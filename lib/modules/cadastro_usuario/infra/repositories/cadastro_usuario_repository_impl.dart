import 'package:dartz/dartz.dart';
import '../../domain/entities/usuario_entity.dart';
import '../../domain/errors/erro_salvar_cadastro_usuario_datasource.dart';
import '../../domain/errors/i_erro_salvar_cadastro_usuario.dart';
import '../../domain/repositories/i_cadastro_usuario_repository.dart';
import '../datasources/i_cadastro_usuario_datasource.dart';
import '../mapper/i_usuario_mapper.dart';

class CadastroUsuarioRepositoryImpl extends ICadastroUsuarioRepository{

  final ICadastroUsuarioDatasource iCadastroUsuarioDatasource;
  final IUsuarioMapper iUsuarioMapper;

  @override
  Future<Either<IErroSalvarCadastroUsuario, int>> salvarCadastroUsuario(UsuarioEntity usuarioEntity) async {
    try {
      final String dataFormatada;
      if (RegExp(r"^([0-2][0-9]|(3)[0-1])(\/)(((0)[0-9])|((1)[0-2]))(\/)\d{4}$").hasMatch(usuarioEntity.dataNascimento)){
         dataFormatada =
            '${usuarioEntity.dataNascimento.substring(6, 10)}-${usuarioEntity
            .dataNascimento.substring(3, 5)}-${usuarioEntity.dataNascimento
            .substring(0, 2)}';
      } else {
        dataFormatada = usuarioEntity.dataNascimento;
      }
      UsuarioEntity usuarioEntityFormatted = UsuarioEntity(nome: usuarioEntity.nome, cpf: usuarioEntity.cpf, dataNascimento: dataFormatada,
          genero: usuarioEntity.genero, email: usuarioEntity.email, senha: usuarioEntity.senha, telefone: usuarioEntity.telefone, endereco: usuarioEntity.endereco, tipoUsuario: usuarioEntity.tipoUsuario);
      final result = await iCadastroUsuarioDatasource.salvarCadastroUsuario(iUsuarioMapper.toUsuarioCreateDto(usuarioEntityFormatted));
      return Right(result);
    } catch (e){
      return left(ErroSalvarCadastroUsuarioDatasource(message: e.toString()));
    }

  }

   CadastroUsuarioRepositoryImpl({
    required this.iCadastroUsuarioDatasource,
    required this.iUsuarioMapper,
  });
}