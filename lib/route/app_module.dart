import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sp_bill/features/login/presentation/blocs/authentication_bloc.dart';
import 'home_module.dart';

class AppModule extends Module {

  // Provide a list of dependencies to inject into your project
  @override
  final List<Bind> binds = [];

  // Provide all the routes for your module
  @override
  final List<ModularRoute> routes = [
    ModuleRoute('/', module: HomeModule(), transition: TransitionType.size,),
    WildcardRoute(child: (_, args) => Container(
      child: Center(child: Text('404')),
    ),),
  ];

}