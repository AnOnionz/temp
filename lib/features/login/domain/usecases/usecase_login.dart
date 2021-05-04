import 'package:dartz/dartz.dart';
import 'package:sp_bill/core/error/failure.dart';
import 'package:sp_bill/core/usecases/usecase.dart';
import 'package:sp_bill/features/login/domain/entities/login_entity.dart';
import 'package:sp_bill/features/login/domain/repositories/login_repository.dart';
import 'package:flutter/foundation.dart';

class LoginUseCase implements UseCase<LoginEntity, LoginParams>{
  final LoginRepository repository;

  LoginUseCase({@required this.repository});
  @override
  Future<Either<Failure, LoginEntity>> call(LoginParams params) async {
      return await repository.login(username: params.username, password: params.password);
  }

}
class LoginParams extends Params{
  final String username;
  final String password;

  LoginParams({@required this.username,@required this.password});

  @override
  List<Object> get props => [username, password];

}