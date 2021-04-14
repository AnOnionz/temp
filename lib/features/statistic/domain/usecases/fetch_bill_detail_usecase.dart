import 'package:sp_bill/core/error/failure.dart';
import 'package:sp_bill/core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:sp_bill/features/statistic/domain/entities/bill_detail.dart';
import 'package:sp_bill/features/statistic/domain/repositories/statistic_repository.dart';

class FetchBillDetailUseCase implements UseCase<BillDetailEntity, BillDetailParams>{
  final StatisticRepository repository;

  FetchBillDetailUseCase({required this.repository});
  @override
  Future<Either<Failure, BillDetailEntity>> call(BillDetailParams params) async {
    return await repository.fetchBillDetail(token: params.token);
  }
}
class BillDetailParams extends Params{
  final String token;

  BillDetailParams({required this.token});
}