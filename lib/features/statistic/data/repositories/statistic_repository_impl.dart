import 'package:dartz/dartz.dart';
import 'package:sp_bill/core/error/Exception.dart';
import 'package:sp_bill/core/error/failure.dart';
import 'package:sp_bill/features/login/data/datasources/login_remote_datasource.dart';
import 'package:sp_bill/features/login/domain/entities/login_entity.dart';
import 'package:sp_bill/features/login/domain/repositories/login_repository.dart';
import 'package:sp_bill/features/statistic/data/datasources/statistic_remote_datasource.dart';
import 'package:sp_bill/features/statistic/domain/entities/user.dart';
import 'package:sp_bill/features/statistic/domain/repositories/statistic_repository.dart';

class StatisticRepositoryImpl implements StatisticRepository{
  final StatisticRemoteDataSource remoteDataSource;

  StatisticRepositoryImpl({required this.remoteDataSource,});

  @override
  Future<Either<Failure, List<UserEntity>>> fetchAllUser() async {
    try {
      final users = await remoteDataSource.fetchAllUser();
      return Right(users);
    } on InternetException catch(_){
      return Left(InternetFailure());
    } on UnAuthenticateException catch (_) {
      return Left(UnAuthenticateFailure());
    } on ResponseException catch (error) {
      return Left(ResponseFailure(message: error.message));
    } on InternalException catch (_) {
      return Left(InternalFailure());
    }
  }


}