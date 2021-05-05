import 'package:sp_bill/core/error/failure.dart';
import 'package:sp_bill/core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:sp_bill/features/statistic/domain/entities/bill_response.dart';
import 'package:flutter/foundation.dart';
import 'package:sp_bill/features/statistic/domain/entities/excel.dart';
import 'package:sp_bill/features/statistic/domain/repositories/statistic_repository.dart';

class FetchAllReportUseCase implements UseCase<List<Map<String, dynamic>>, ReportParams>{
  final StatisticRepository repository;

  FetchAllReportUseCase({@required this.repository});
  @override
  Future<Either<Failure, List<Map<String, dynamic>>>> call(ReportParams params) async {
    return await repository.fetchAllReport(allPath: params.allPath);
  }
}
class ReportParams extends Params{
  final List<String> allPath;

  ReportParams({this.allPath});
}