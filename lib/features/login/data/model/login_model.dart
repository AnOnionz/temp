import 'package:sp_bill/features/login/domain/entities/login_entity.dart';
import 'package:flutter/foundation.dart';
class LoginModel extends LoginEntity {

  LoginModel({
    @required int id,
    @required String name,
    @required String accessToken,
    @required int role,

  }): super(id: id, userName: name, accessToken: accessToken, role: role);

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      id: json['id'] as int,
      name: json['username'],
      accessToken: json['access_token'],
      role: json['role'],
    );
  }
}