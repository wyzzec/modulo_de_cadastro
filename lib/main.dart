import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'global/app_module.dart';
import 'global/presenter/widgets/app_widget.dart';

void main() {

  runApp(ModularApp(module: AppModule(), child: AppWidget()));

}