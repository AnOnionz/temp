import 'package:dartz/dartz.dart';
import 'package:sp_bill/core/error/failure.dart';
import 'package:sp_bill/features/statistic/domain/entities/bill_response.dart';
import 'package:sp_bill/features/statistic/domain/entities/user.dart';
import 'package:sp_bill/features/statistic/domain/entities/user_bill_response.dart';

abstract class StatisticRepository{
  Future<Either<Failure, List<UserEntity>>> fetchAllUser();
  Future<Either<Failure, UserBillResponse>> fetchAllUserBill({int? begin,int? end, int? userId});
  Future<Either<Failure, BillResponse>> fetchAllBill({int? begin, int? end, int? status, int? billId, String? outletCode, required int userId, int? page});
}