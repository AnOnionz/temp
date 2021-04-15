import 'package:flutter_modular/flutter_modular.dart';
import 'package:sp_bill/features/login/presentation/screens/login_page.dart';
import '../authen_widget.dart';
import '../features/statistic/presentation/screens/bills.dart';
import '../features/statistic/presentation/screens/edit.dart';
import '../features/statistic/presentation/screens/users.dart';


class HomeModule extends Module {
  @override
  final List<Bind> binds = [

  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => AuthenticateWidget(child: Users(),)),
    ChildRoute('/login', child: (_, args) => LoginPage()),
    ChildRoute('/statistic', child: (_, args) => AuthenticateWidget(child: Users()),),
    ChildRoute(
      '/bill/:token',
      child: (_, args) => AuthenticateWidget(child: Edit(token: args.params['token'])),
    ),
    ChildRoute(
      '/statistic/:id',
      child: (_, args) => AuthenticateWidget(child: Bills(id: args.params['id'])),
    ),
  ];
}