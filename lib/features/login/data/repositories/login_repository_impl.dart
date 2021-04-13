import 'package:dartz/dartz.dart';
import 'package:sp_bill/core/error/Exception.dart';
import 'package:sp_bill/core/error/failure.dart';
import 'package:sp_bill/features/login/data/datasources/login_remote_datasource.dart';
import 'package:sp_bill/features/login/domain/entities/login_entity.dart';
import 'package:sp_bill/features/login/domain/repositories/login_repository.dart';

class LoginRepositoryImpl implements LoginRepository{
  final LoginRemoteDataSource remoteDataSource;

  LoginRepositoryImpl({required this.remoteDataSource,});
  @override
  Future<Either<Failure, LoginEntity>> login({required String username, required String password}) async {
      try {
        final loginEntity = await remoteDataSource.login(
            username: username, password: password);
        return Right(loginEntity);
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
  @override
  Future<Either<Failure, bool>> logout() async {
      try {
        final logout = await remoteDataSource.logout();
        return Right(logout);
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