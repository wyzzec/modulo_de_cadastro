import 'package:flutter_modular/flutter_modular.dart';
import 'package:modulo_de_cadastro/global/presenter/pages/splash_page.dart';
import '../modules/home_page/home_page_module.dart';



class AppModule extends Module {

  @override
  List<Module> get imports => [
   HomePageModule()
  ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const SplashPage(), transition: TransitionType.rightToLeftWithFade,),
        ModuleRoute('/homepage/', module: HomePageModule(), transition: TransitionType.rightToLeft,),
      ];
}