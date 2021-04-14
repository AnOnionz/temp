import 'dart:developer';

import 'package:equatable/equatable.dart';

class UserBillEntity extends Equatable{
  final int userId;
  final String userName;
  final String time;
  final int done;
  final int error;
  final int imageError;

  UserBillEntity({required this.userId, required this.userName, required this.time, required this.done, required this.error, required this.imageError});
  @override
  List<Object?> get props => [
    userId,
    userName,
    time,
    done,
    error,
    imageError
  ];

}