
import 'package:sp_bill/features/statistic/domain/entities/user.dart';

class UserModel extends UserEntity {

  UserModel({
    required int id,
    required String userName,
    required int total,
    required int done,

  }): super(id: id, userName: userName, done: done, total: total);

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['user_id'] as int,
      userName: json['username'],
      total: json['total'],
      done: json['done']
    );
  }
}