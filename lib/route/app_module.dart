import 'package:flutter/material.dart';
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
import 'package:sp_bill/features/statistic/data/datasources/statistic_remote_datasource.dart';
import 'package:sp_bill/features/statistic/data/repositories/statistic_repository_impl.dart';
import 'package:sp_bill/features/statistic/domain/usecases/fetch_all_bill_usecase.dart';
import 'package:sp_bill/features/statistic/domain/usecases/fetch_all_user_bill_usecase.dart';
import 'package:sp_bill/features/statistic/domain/usecases/fetch_all_user_usecase.dart';
import 'package:sp_bill/features/statistic/domain/usecases/fetch_bill_detail_usecase.dart';
import 'package:sp_bill/features/statistic/presentation/bloc/bill_cubit.dart';
import 'package:sp_bill/features/statistic/presentation/bloc/bill_detail_cubit.dart';
import 'package:sp_bill/features/statistic/presentation/bloc/userbill_cubit.dart';
import 'package:sp_bill/features/statistic/presentation/bloc/users_cubit.dart';
import 'home_module.dart';

class AppModule extends Module {

  // Provide a list of dependencies to inject into your project
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => AuthenticationBloc(localStorage: i.get<LocalStorage>())),
    Bind.lazySingleton((i) => LoginBloc(login: i.get<LoginUseCase>(), logout: i.get<LogoutUseCase>(),authenticationBloc: i.get<AuthenticationBloc>())),
    Bind.lazySingleton((i) => LocalStorage('sp_bill')),
    Bind.lazySingleton((i) => LoginUseCase(repository: i.get<LoginRepository>())),
    Bind.lazySingleton((i) => LogoutUseCase(repository: i.get<LoginRepository>())),
    Bind.lazySingleton((i) => LoginRepositoryImpl(remoteDataSource: i.get<LoginRemoteDataSourceImpl>())),
    Bind.lazySingleton((i) => LoginRemoteDataSourceImpl(cDio: i.get<CDio>())),
    Bind.lazySingleton((i) => CDio()),
    Bind.lazySingleton((i) => UsersCubit(fetchAllUser: i.get<FetchAllUserUseCase>())),
    Bind.lazySingleton((i) => UserBillCubit(fetchAllUserBill: i.get<FetchAllUserBillUseCase>())),
    Bind.lazySingleton((i) => BillCubit(fetchAllBill: i.get<FetchAllBillUseCase>())),
    Bind.factory((i) => BillDetailCubit(fetchBillDetail: i.get<FetchBillDetailUseCase>())),
    Bind.lazySingleton((i) => FetchAllUserUseCase(repository: i.get<StatisticRepositoryImpl>())),
    Bind.lazySingleton((i) => FetchAllUserBillUseCase(repository: i.get<StatisticRepositoryImpl>())),
    Bind.lazySingleton((i) => FetchAllBillUseCase(repository: i.get<StatisticRepositoryImpl>())),
    Bind.lazySingleton((i) => FetchBillDetailUseCase(repository: i.get<StatisticRepositoryImpl>())),
    Bind.lazySingleton((i) => StatisticRepositoryImpl(remoteDataSource: i.get<StatisticRemoteDataSourceImpl>(),authenticationBloc: i.get<AuthenticationBloc>())),
    Bind.lazySingleton((i) => StatisticRemoteDataSourceImpl(cDio: i.get<CDio>())),

  ];

  // Provide all the routes for your module
  @override
  final List<ModularRoute> routes = [
    ModuleRoute('/', module: HomeModule(), transition: TransitionType.size, duration: Duration(seconds: 2)),
    WildcardRoute(child: (_, args) => Container(
      child: Center(child: Text('404')),
    ),),
  ];

}