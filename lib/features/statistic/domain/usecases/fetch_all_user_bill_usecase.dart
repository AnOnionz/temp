import 'package:sp_bill/core/error/failure.dart';
import 'package:sp_bill/core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:sp_bill/features/statistic/domain/entities/user_bill_response.dart';
import 'package:sp_bill/features/statistic/domain/repositories/statistic_repository.dart';

class FetchAllUserBillUseCase implements UseCase<UserBillResponse, UserBillParam>{
  final StatisticRepository repository;

  FetchAllUserBillUseCase({@required this.repository});
  @override
  Future<Either<Failure, UserBillResponse>> call(UserBillParam params) async {
    return await repository.fetchAllUserBill(begin: params.begin, end: params.end, userId: params.userId);
  }
}
class UserBillParam extends Params{
  final int begin;
  final int end;
  final int userId;

  UserBillParam({ this.begin,this.end,this.userId});
}