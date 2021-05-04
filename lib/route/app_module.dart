
import 'package:flutter_modular/flutter_modular.dart';
import 'package:localstorage/localstorage.dart';
import 'package:sp_bill/core/api/myDio.dart';

import '../404.dart';
import 'home_module.dart';

class AppModule extends Module {

  // Provide a list of dependencies to inject into your project
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => CDio()),
    Bind.lazySingleton((i) => LocalStorage('sp_bill')),
  ];
  // Provide all the routes for your module
  @override
  final List<ModularRoute> routes = [
    ModuleRoute('/', module: HomeModule(), transition: TransitionType.size, duration: Duration(seconds: 2)),
    WildcardRoute(child: (_, args) => ErrorPage(is404: true,),
      ),
  ];

}