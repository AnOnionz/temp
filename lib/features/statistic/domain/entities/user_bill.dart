import 'package:flutter/foundation.dart';
import 'package:equatable/equatable.dart';

class UserBillEntity extends Equatable{
  final int userId;
  final String userName;
  final String time;
  final int done;
  final int error;
  final int imageError;

  UserBillEntity({@required this.userId, @required this.userName, @required this.time, @required this.done, @required this.error, @required this.imageError});

  @override
  List<Object> get props => [
    userId,
    userName,
    time,
    done,
    error,
    imageError
  ];
  Map<String, dynamic> toJson(){
    return {
      'ID': userId,
      'User': userName,
      'Thời gian nhập': time,
      'Đã nhập': done,
      'Lỗi hình': imageError,
      'Thiếu thông tin': error,
    };
  }


}