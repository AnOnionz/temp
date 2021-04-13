import 'package:sp_bill/core/error/failure.dart';
import 'package:sp_bill/core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:sp_bill/features/statistic/domain/entities/user.dart';
import 'package:sp_bill/features/statistic/domain/repositories/statistic_repository.dart';

class FetchAllUserUseCase implements UseCase<List<UserEntity>, NoParams>{
  final StatisticRepository repository;

  FetchAllUserUseCase({required this.repository});
  @override
  Future<Either<Failure, List<UserEntity>>> call(NoParams noParams) async {
    return await repository.fetchAllUser();
  }
}