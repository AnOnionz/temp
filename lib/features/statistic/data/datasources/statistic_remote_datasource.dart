import 'package:flutter_modular/flutter_modular.dart';
import 'package:sp_bill/core/api/myDio.dart';
import 'package:sp_bill/core/error/Exception.dart';
import 'package:sp_bill/core/utils/string_tranform.dart';
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
  Future<List<String>> fetchAllPart({int begin, int end, int status, int billId, String outletCode, int userId});
  Future<List<Map<String, dynamic>>> fetchAllReport({@required List<String> allPath});
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
  Future<List<String>> fetchAllPart({int begin, int end, int status, int billId, String outletCode, int userId}) async {
    Map<String, dynamic> params
    = {
      'bill_id': billId,
      'outlet_code' : outletCode,
      'begin': begin,
      'end': end,
      'status': status,
      'user_id': userId,
    };
    Response _resp = await cDio.getResponse(path: 'supervisor/export', data: params);
    return (_resp.data as List<dynamic>).map((e) => e.toString()).toList();
  }

  @override
  Future<List<Map<String, dynamic>>> fetchAllReport({List<String> allPath}) async {
    final List<Map<String, dynamic>> data = [];

    await Future.forEach(allPath, (url) async {
      // Response _resp = await cDio.getResponse(
      //     path: url
      //         .split('api/')
      //         .last);
      Response _resp = await getReport(url);
      data.addAll(
          (await compute(parseData, _resp.data as List<dynamic>)));
      await Future.delayed(Duration(milliseconds: 100));
    });
    return data;
  }
}
Future<Response> getReport(String path) async {
  Response _resp = await Modular.get<CDio>().getResponse(
      path: path
          .split('api/')
          .last);
  return _resp;
}
List<Map<String, dynamic>> parseData(List<dynamic> json) {
  return json.map<Map<String, dynamic>>((e) => {
    'bill_id': e['bill_id'],
    'outlet_code': e['outlet_code'],
    'channel': e['channel'],
    'outlet_name': e['outlet_name'],
    'province': e['province'],
    'industry_name': e['industry_name'],
    'total_bill': moneyTransform(e['total_bill'] ?? 0),
    'product_name': e['product_name'],
    'qty': e['qty'],
    'unit': e['unit'],
    'unit_price': moneyTransform(e['unit_price'] ?? 0),
    'total_money': moneyTransform(e['total_money'] ?? 0),
    'note': e['note'],
    'created_by': e['created_by'],
    'created_at': (e['created_at'] as String).split(' ').last.split('/').sublist(0,2).map((e) => int.parse(e)).toList().join('/')
  }).toList();
}