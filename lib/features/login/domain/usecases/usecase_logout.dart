import 'package:dartz/dartz.dart';
import 'package:sp_bill/core/error/failure.dart';
import 'package:sp_bill/core/usecases/usecase.dart';
import 'package:sp_bill/features/login/domain/repositories/login_repository.dart';

class LogoutUseCase implements UseCase<bool, NoParams>{
  final LoginRepository repository;

  LogoutUseCase({required this.repository});
  @override
  Future<Either<Failure, bool>> call(NoParams noParams) async  {
    return await repository.logout();
  }
}