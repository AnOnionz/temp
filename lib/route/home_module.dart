import 'package:flutter_modular/flutter_modular.dart';
import 'package:localstorage/localstorage.dart';
import '../core/api/myDio.dart';
import '../features/login/presentation/blocs/authentication_bloc.dart';
import '../features/login/presentation/screens/login_page.dart';
import '../features/statistic/domain/usecases/fetch_all_part_usecase.dart';
import '../features/statistic/domain/usecases/fetch_all_report_usecase.dart';
import '../features/statistic/presentation/bloc/excel_cubit.dart';
import '../authen_widget.dart';
import '../features/login/data/datasources/login_remote_datasource.dart';
import '../features/login/data/repositories/login_repository_impl.dart';
import '../features/login/domain/repositories/login_repository.dart';
import '../features/login/domain/usecases/usecase_login.dart';
import '../features/login/domain/usecases/usecase_logout.dart';
import '../features/login/presentation/blocs/login_bloc.dart';
import '../features/statistic/presentation/screens/bills.dart';
import '../features/statistic/presentation/screens/edit.dart';
import '../features/statistic/presentation/screens/users.dart';
import '../features/statistic/data/datasources/statistic_remote_datasource.dart';
import '../features/statistic/data/repositories/statistic_repository_impl.dart';
import '../features/statistic/domain/usecases/fetch_all_bill_usecase.dart';
import '../features/statistic/domain/usecases/fetch_all_user_bill_usecase.dart';
import '../features/statistic/domain/usecases/fetch_all_user_usecase.dart';
import '../features/statistic/domain/usecases/fetch_bill_detail_usecase.dart';
import '../features/statistic/presentation/bloc/bill_cubit.dart';
import '../features/statistic/presentation/bloc/bill_detail_cubit.dart';
import '../features/statistic/presentation/bloc/userbill_cubit.dart';
import '../features/statistic/presentation/bloc/users_cubit.dart';

class HomeModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => AuthenticationBloc(localStorage: i.get<LocalStorage>())),
    Bind.lazySingleton((i) => LoginBloc(login: i.get<LoginUseCase>(), logout: i.get<LogoutUseCase>(),authenticationBloc: i.get<AuthenticationBloc>())),
    Bind.lazySingleton((i) => LoginUseCase(repository: i.get<LoginRepository>())),
    Bind.lazySingleton((i) => LogoutUseCase(repository: i.get<LoginRepository>())),
    Bind.lazySingleton((i) => LoginRepositoryImpl(remoteDataSource: i.get<LoginRemoteDataSourceImpl>())),
    Bind.lazySingleton((i) => LoginRemoteDataSourceImpl(cDio: i.get<CDio>())),
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
    Bind.factory((i) => ExcelCubit(fetchAllPart: i.get<FetchAllPartUseCase>(), fetchAllReport: i.get<FetchAllReportUseCase>())),
    Bind.lazySingleton((i) => FetchAllPartUseCase(repository: i.get<StatisticRepositoryImpl>())),
    Bind.lazySingleton((i) => FetchAllReportUseCase(repository: i.get<StatisticRepositoryImpl>()))
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
    ChildRoute(
      '/statistic/:id/:time',
      child: (_, args) => AuthenticateWidget(child: Bills(id: args.params['id'], time: args.params['time'],)),
    ),
  ];
}