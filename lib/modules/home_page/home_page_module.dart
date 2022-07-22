import 'package:flutter_modular/flutter_modular.dart';
import 'package:modulo_de_cadastro/modules/home_page/presenter/home_page.dart';
import '../cadastro_usuario/cadastro_usuario_module.dart';

class HomePageModule extends Module {
  @override
  List<Module> get imports => [
        CadastroModule(),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const HomePage()),
        ModuleRoute('/cadastrarusuario/', module: CadastroModule()),
      ];
}
