import 'package:sp_bill/core/error/failure.dart';
import 'package:sp_bill/core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:sp_bill/features/statistic/domain/repositories/statistic_repository.dart';

class FetchAllPartUseCase implements UseCase<List<String>, FetchPathParams>{
  final StatisticRepository repository;

  FetchAllPartUseCase({@required this.repository});
  @override
  Future<Either<Failure, List<String>>> call(FetchPathParams params) async {
    return await repository.fetchAllPath(billId: params.billId, begin: params.begin, end: params.end, status: params.status, outletCode: params.outletCode, userId: params.userId);
  }
}
class FetchPathParams extends Params {
  final int begin;
  final int end;
  final int status;
  final int billId;
  final String outletCode;
  final int userId;

  FetchPathParams({this.begin, this.end, this.status, this.billId, this.outletCode, this.userId});
}
