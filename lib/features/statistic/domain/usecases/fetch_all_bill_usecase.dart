import 'package:sp_bill/core/error/failure.dart';
import 'package:sp_bill/core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:sp_bill/features/statistic/domain/entities/bill_response.dart';
import 'package:flutter/foundation.dart';
import 'package:sp_bill/features/statistic/domain/repositories/statistic_repository.dart';

class FetchAllBillUseCase implements UseCase<BillResponse, BillParams>{
  final StatisticRepository repository;

  FetchAllBillUseCase({@required this.repository});
  @override
  Future<Either<Failure, BillResponse>> call(BillParams params) async {
    return await repository.fetchAllBill(userId: params.userId, begin: params.begin, end: params.end, outletCode: params.outletCode, billId: params.billId, status: params.status, page: params.page);
  }
}
class BillParams extends Params{
  final int begin;
  final int end;
  final int status;
  final int billId;
  final String outletCode;
  final int userId;
  final int page;

  BillParams({this.begin, this.end, this.status, this.billId, this.outletCode, @required this.userId, this.page});
}