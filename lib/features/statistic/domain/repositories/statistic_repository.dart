import 'package:dartz/dartz.dart';
import 'package:sp_bill/core/error/failure.dart';
import 'package:sp_bill/features/statistic/domain/entities/bill_detail.dart';
import 'package:sp_bill/features/statistic/domain/entities/bill_response.dart';
import 'package:sp_bill/features/statistic/domain/entities/excel.dart';
import 'package:sp_bill/features/statistic/domain/entities/user.dart';
import 'package:sp_bill/features/statistic/domain/entities/user_bill_response.dart';
import 'package:flutter/foundation.dart';

abstract class StatisticRepository{
  Future<Either<Failure, List<UserEntity>>> fetchAllUser();
  Future<Either<Failure, UserBillResponse>> fetchAllUserBill({int begin,int end, int userId});
  Future<Either<Failure, BillResponse>> fetchAllBill({int begin, int end, int status, int billId, String outletCode, @required int userId, int page});
  Future<Either<Failure, BillDetailEntity>> fetchBillDetail({@required String token});
  Future<Either<Failure, List<String>>> fetchAllPath({int begin, int end, int status, int billId, String outletCode, int userId});
  Future<Either<Failure, List<Map<String, dynamic>>>> fetchAllReport({@required List<String> allPath});

}