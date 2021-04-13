import 'package:flutter_modular/flutter_modular.dart';
import 'package:localstorage/localstorage.dart';
import 'package:sp_bill/core/api/myDio.dart';
import 'package:sp_bill/features/login/data/datasources/login_remote_datasource.dart';
import 'package:sp_bill/features/login/data/repositories/login_repository_impl.dart';
import 'package:sp_bill/features/login/domain/repositories/login_repository.dart';
import 'package:sp_bill/features/login/domain/usecases/usecase_login.dart';
import 'package:sp_bill/features/login/domain/usecases/usecase_logout.dart';
import 'package:sp_bill/features/login/presentation/blocs/authentication_bloc.dart';
import 'package:sp_bill/features/login/presentation/blocs/login_bloc.dart';
import 'package:sp_bill/features/login/presentation/screens/login_page.dart';
import 'package:sp_bill/features/statistic/data/datasources/statistic_remote_datasource.dart';
import 'package:sp_bill/features/statistic/data/repositories/statistic_repository_impl.dart';
import 'package:sp_bill/features/statistic/domain/usecases/fetch_all_user_usecase.dart';
import 'package:sp_bill/features/statistic/presentation/bloc/users_cubit.dart';
import '../features/statistic/presentation/screens/bills.dart';
import '../features/statistic/presentation/screens/edit.dart';
import '../features/statistic/presentation/screens/users.dart';
import '../app.dart';


class HomeModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => LocalStorage('sp_bill')),
    Bind.lazySingleton((i) => AuthenticationBloc(localStorage: i.get<LocalStorage>())),
    Bind.lazySingleton((i) => LoginBloc(login: i.get<LoginUseCase>(), logout: i.get<LogoutUseCase>(),authenticationBloc: i.get<AuthenticationBloc>())),
    Bind.lazySingleton((i) => LoginUseCase(repository: i.get<LoginRepository>())),
    Bind.lazySingleton((i) => LogoutUseCase(repository: i.get<LoginRepository>())),
    Bind.lazySingleton((i) => LoginRepositoryImpl(remoteDataSource: i.get<LoginRemoteDataSourceImpl>())),
    Bind.lazySingleton((i) => LoginRemoteDataSourceImpl(cDio: i.get<CDio>())),
    Bind.lazySingleton((i) => CDio()),
    Bind.factory((i) => UsersCubit(fetchAllUser: i.get<FetchAllUserUseCase>())),
    Bind.lazySingleton((i) => FetchAllUserUseCase(repository: i.get<StatisticRepositoryImpl>())),
    Bind.lazySingleton((i) => StatisticRepositoryImpl(remoteDataSource: i.get<StatisticRemoteDataSourceImpl>())),
    Bind.lazySingleton((i) => StatisticRemoteDataSourceImpl(cDio: i.get<CDio>())),
  ];

  @override
  final List<ModularRoute> routes = [

    ChildRoute('/', child: (_, args) => MyApp()),
    ChildRoute('/login', child: (_, args) => LoginPage()),
    ChildRoute('/statistic', child: (_, args) => Users(),),
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