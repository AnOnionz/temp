import 'package:sp_bill/core/api/myDio.dart';
import 'package:sp_bill/features/statistic/data/model/user_model.dart';
import 'package:sp_bill/features/statistic/domain/entities/user.dart';

abstract class StatisticRemoteDataSource {
  Future<List<UserEntity>> fetchAllUser();
    // Future<List<User>> fetchAllUser();
    // Future<List<User>> fetchAllUser();
}

class StatisticRemoteDataSourceImpl implements StatisticRemoteDataSource{
  final CDio cDio;

  StatisticRemoteDataSourceImpl({required this.cDio});

  @override
  Future<List<UserEntity>> fetchAllUser() async  {
    Response _resp = await cDio.getResponse(path: 'supervisor/users',);
    print(_resp);
     return (_resp.data as List<dynamic>).map((e) => UserModel.fromJson(e)).toList();
  }
}