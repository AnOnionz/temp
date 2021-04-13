import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sp_bill/features/statistic/data/datasources/statistic_remote_datasource.dart';
import 'package:sp_bill/features/statistic/data/repositories/statistic_repository_impl.dart';
import 'package:sp_bill/features/statistic/domain/repositories/statistic_repository.dart';
import 'package:sp_bill/features/statistic/domain/usecases/fetch_all_user_usecase.dart';

import 'core/api/myDio.dart';
import 'features/login/data/datasources/login_remote_datasource.dart';
import 'features/login/data/repositories/login_repository_impl.dart';
import 'features/login/domain/repositories/login_repository.dart';
import 'features/login/domain/usecases/usecase_login.dart';
import 'features/login/domain/usecases/usecase_logout.dart';
import 'features/login/presentation/blocs/authentication_bloc.dart';
import 'features/login/presentation/blocs/login_bloc.dart';
import 'features/statistic/presentation/bloc/users_cubit.dart';

final sl = GetIt.instance;
Future<void> init() async {
  //! Core
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  //! External
  sl.registerLazySingleton<CDio>(() => CDio());
  //! Features - Login //
  // Data sources
  sl.registerLazySingleton<LoginRemoteDataSource>(
          () => LoginRemoteDataSourceImpl(cDio: sl()));
  // Repository
  sl.registerLazySingleton<LoginRepository>(
          () =>
          LoginRepositoryImpl(
            remoteDataSource: sl(),));
  //Use case
  sl.registerLazySingleton<LoginUseCase>(() => LoginUseCase(repository: sl()));
  sl.registerLazySingleton<LogoutUseCase>(
          () => LogoutUseCase(repository: sl()));
  // Bloc
  sl.registerLazySingleton<AuthenticationBloc>(
          () => AuthenticationBloc(preferences: sl()));
  sl.registerFactory<LoginBloc>(
          () =>
          LoginBloc(login: sl(),
              logout: sl(),
              authenticationBloc: sl()));

  //! Features - Statistic
  //Data Source
  sl.registerLazySingleton<StatisticRemoteDataSource>(() => StatisticRemoteDataSourceImpl(cDio: sl()));
  //Repository
  sl.registerLazySingleton<StatisticRepository>(() => StatisticRepositoryImpl(remoteDataSource: sl()));
  //Use Case
  sl.registerLazySingleton<FetchAllUserUseCase>(() => FetchAllUserUseCase(repository: sl()));
  //Bloc-Cubit
  sl.registerFactory<UsersCubit>(() => UsersCubit(fetchAllUser: sl()));
}