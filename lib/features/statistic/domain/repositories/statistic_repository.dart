import 'package:dartz/dartz.dart';
import 'package:sp_bill/core/error/failure.dart';
import 'package:sp_bill/features/statistic/domain/entities/user.dart';

abstract class StatisticRepository{
  Future<Either<Failure, List<UserEntity>>> fetchAllUser();
}