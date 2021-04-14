import 'package:sp_bill/core/api/myDio.dart';
import 'package:sp_bill/features/statistic/data/model/bill_response_model.dart';
import 'package:sp_bill/features/statistic/data/model/user_bill_response_model.dart';
import 'package:sp_bill/features/statistic/data/model/user_model.dart';
import 'package:sp_bill/features/statistic/domain/entities/bill_response.dart';
import 'package:sp_bill/features/statistic/domain/entities/user.dart';
import 'package:sp_bill/features/statistic/domain/entities/user_bill_response.dart';

abstract class StatisticRemoteDataSource {
  Future<List<UserEntity>> fetchAllUser();
  Future<UserBillResponse> fetchAllUserBill({int? begin,int? end, int? userId});
  Future<BillResponse> fetchAllBill({int? begin, int? end, int? status, int? billId, String? outletCode, required int userId,int? page});
}

class StatisticRemoteDataSourceImpl implements StatisticRemoteDataSource{
  final CDio cDio;

  StatisticRemoteDataSourceImpl({required this.cDio});

  @override
  Future<List<UserEntity>> fetchAllUser() async  {
    Response _resp = await cDio.getResponse(path: 'home/users',);
    print(_resp);
     return (_resp.data as List<dynamic>).map((e) => UserModel.fromJson(e)).toList();
  }

  @override
  Future<UserBillResponse> fetchAllUserBill({int? begin,int? end, int? userId}) async {
    Map<String, dynamic> params
    = {
      'begin': begin,
      'end': end,
      'user': userId == 0 ? null : userId,
    };
    Response _resp = await cDio.getResponse(path: 'supervisor/statistic-user', data: params);
    print(params);
    return UserBillResponseModel.fromJson(_resp.data);
  }

  @override
  Future<BillResponse> fetchAllBill({int? begin, int? end, int? status, int? billId, String? outletCode, required int userId, int? page}) async {
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
    print(params);
    Response _resp = await cDio.getResponse(path: 'supervisor/statistic-bill', data: params);
    print(_resp);
    return BillResponseModel.fromJson(_resp.data);
  }
}