import 'package:flutter_modular/flutter_modular.dart';
import 'package:sp_bill/core/api/myDio.dart';
import 'package:sp_bill/core/error/Exception.dart';
import 'package:sp_bill/features/statistic/data/model/bill_detail_model.dart';
import 'package:sp_bill/features/statistic/data/model/bill_response_model.dart';
import 'package:sp_bill/features/statistic/data/model/excel_model.dart';
import 'package:sp_bill/features/statistic/data/model/user_bill_response_model.dart';
import 'package:sp_bill/features/statistic/data/model/user_model.dart';
import 'package:sp_bill/features/statistic/domain/entities/bill_detail.dart';
import 'package:sp_bill/features/statistic/domain/entities/bill_response.dart';
import 'package:sp_bill/features/statistic/domain/entities/excel.dart';
import 'package:sp_bill/features/statistic/domain/entities/user.dart';
import 'package:sp_bill/features/statistic/domain/entities/user_bill_response.dart';
import 'package:flutter/foundation.dart';

abstract class StatisticRemoteDataSource {
  Future<List<UserEntity>> fetchAllUser();
  Future<UserBillResponse> fetchAllUserBill({int begin,int end, int userId});
  Future<BillResponse> fetchAllBill({int begin, int end, int status, int billId, String outletCode, @required int userId,int page});
  Future<BillDetailEntity> fetchBillDetail({@required String token});
  Future<List<String>> fetchAllPart({int begin, int end, int status, int billId, String outletCode});
  Future<List<ExcelEntity>> fetchAllReport({@required List<String> allPath});
}

class StatisticRemoteDataSourceImpl implements StatisticRemoteDataSource{
  final CDio cDio;


  StatisticRemoteDataSourceImpl({@required this.cDio});

  @override
  Future<List<UserEntity>> fetchAllUser() async  {
    Response _resp = await cDio.getResponse(path: 'home/users',);

    return (_resp.data as List<dynamic>).map((e) => UserModel.fromJson(e)).toList();
  }

  @override
  Future<UserBillResponse> fetchAllUserBill({int begin,int end, int userId}) async {
    Map<String, dynamic> params
    = {
      'begin': begin,
      'end': end,
      'user': userId == 0 ? null : userId,
    };
    Response _resp = await cDio.getResponse(path: 'supervisor/statistic-user', data: params);

    return UserBillResponseModel.fromJson(_resp.data);
  }

  @override
  Future<BillResponse> fetchAllBill({int begin, int end, int status, int billId, String outletCode, @required int userId, int page}) async {
    Map<String, dynamic> params
    = {
      'user_id': userId,
      'bill_id': billId,
      'outlet_code' : outletCode,
      'begin': begin,
      'end': end,
      'status': status,
      'page': page
    };

    Response _resp = await cDio.getResponse(path: 'supervisor/statistic-bill', data: params);

    return BillResponseModel.fromJson(_resp.data);
  }

  @override
  Future<BillDetailEntity> fetchBillDetail({@required String token}) async{
    Response _resp = await cDio.getResponse(path: 'bill/detail?billToken=$token');

    return BillDetailModel.fromJson(_resp.data);
  }

  @override
  Future<List<String>> fetchAllPart({int begin, int end, int status, int billId, String outletCode}) async {
    Map<String, dynamic> params
    = {
      'bill_id': billId,
      'outlet_code' : outletCode,
      'begin': begin,
      'end': end,
      'status': status,
    };
    Response _resp = await cDio.getResponse(path: 'supervisor/export', data: params);
    return (_resp.data as List<dynamic>).map((e) => e.toString()).toList();
  }

  @override
  Future<List<ExcelEntity>> fetchAllReport({List<String> allPath}) async {
    final List<ExcelEntity> data = [];

    await Future.forEach(allPath.sublist(0,2), (url) async {
      Response _resp = await cDio.getResponse(
          path: url
              .split('api/')
              .last);
      data.addAll(
          (_resp.data as List<dynamic>).map((e) => ExcelModel.fromJson(e)));
      await Future.delayed(Duration(milliseconds: 200));
    });
    return data;
  }
}
// Future<Response> getReport(int index) async {
//   return await Modular.get<CDio>().getResponse(path: 'supervisor/export-detail?page=$index');
// }