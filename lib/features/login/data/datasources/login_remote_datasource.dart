import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:sp_bill/core/api/myDio.dart';
import 'package:sp_bill/features/login/data/model/login_model.dart';


abstract class LoginRemoteDataSource {
  Future<LoginModel> login({required String username, required String password});
  Future<bool> logout();
}
class LoginRemoteDataSourceImpl implements LoginRemoteDataSource{
  final CDio cDio;

  LoginRemoteDataSourceImpl({required this.cDio});
  @override
  Future<LoginModel> login({required String username, required String password}) async {
    Map<String, dynamic> _requestBody = {
    'username': username,
    'password': password,
  };
    print(_requestBody);

  Response _resp = await cDio.postResponse(path: 'auth/login', data: _requestBody);
  print(_resp.data);
  return LoginModel.fromJson(_resp.data);

}
  @override
  Future<bool> logout() async {

    Response _resp = await cDio.getResponse(path:'home/logout');

    return _resp.data["success"];

  }

}