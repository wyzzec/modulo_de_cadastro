
import '../../domain/entities/usuario_entity.dart';
import '../dto/endereco_dto.dart';
import '../dto/usuario_create_dto.dart';
import 'i_endereco_mapper.dart';
import 'i_usuario_mapper.dart';

class UsuarioMapperImpl implements IUsuarioMapper{

  final IEnderecoMapper iEnderecoMapper;


  @override
  UsuarioCreateDto toUsuarioCreateDto(UsuarioEntity usuarioEntity) {


    EnderecoDto enderecoDto = iEnderecoMapper.toEnderecoDto(usuarioEntity.endereco);

    return UsuarioCreateDto(nome: usuarioEntity.nome,
        cpf: usuarioEntity.cpf,
        dataNascimento: usuarioEntity.dataNascimento,
        genero: usuarioEntity.genero,
        email: usuarioEntity.email,
        senha: usuarioEntity.senha,
        telefone: usuarioEntity.telefone,
        endereco: enderecoDto,
        tipoUsuario: usuarioEntity.tipoUsuario);
  }

  const UsuarioMapperImpl({
    required this.iEnderecoMapper,
  });
}