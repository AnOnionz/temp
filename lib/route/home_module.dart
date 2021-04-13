import 'package:flutter_modular/flutter_modular.dart';
import 'package:sp_bill/features/login/presentation/screens/login_page.dart';
import '../features/statistic/presentation/screens/bills.dart';
import '../features/statistic/presentation/screens/edit.dart';
import '../features/statistic/presentation/screens/users.dart';
import '../app.dart';



class HomeModule extends Module {
  @override
  final List<Bind> binds = [
    // Bind.singleton((i) => HomeBloc()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => MyApp()),
    ChildRoute('/login', child: (_, args) => LoginPage()),
    ChildRoute('/statistic', child: (_, args) => Users()),
    ChildRoute(
      '/statistic/:id/edit',
      child: (_, args) => Edit(id: args.params['id']),
    ),
    ChildRoute(
      '/statistic/:id',
      child: (_, args) => Bills(id: args.params['id']),
    ),
  ];
}