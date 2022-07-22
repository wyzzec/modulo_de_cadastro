import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'core/app_module.dart';
import 'core/presenter/widgets/app_widget.dart';

void main() {

  runApp(ModularApp(module: AppModule(), child: AppWidget()));

}