import 'package:flutter/foundation.dart';
import 'package:sp_bill/features/statistic/domain/entities/user.dart';

class UserModel extends UserEntity {

  UserModel({
    @required int id,
    @required String userName,

  }): super(id: id, userName: userName,);

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as int,
      userName: json['username'],
    );
  }
}