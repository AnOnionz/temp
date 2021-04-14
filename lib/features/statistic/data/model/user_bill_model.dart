import 'package:sp_bill/features/statistic/domain/entities/user_bill.dart';

class UserBillModel extends UserBillEntity{
  UserBillModel({
    required int userId,
    required String userName,
    required int done,
    required int error,
    required int imageError,
    required String time
}): super(userId: userId, userName: userName,done: done, error: error, imageError: imageError, time: time);

  factory UserBillModel.fromJson(Map<String, dynamic> json){
    return UserBillModel(
      userId: json['user_id'],
      userName: json['username'],
      time:json['time'],
      done: json['done'],
      error: json['error'],
      imageError: json['image_error']
    );
  }
}