import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
class UserEntity extends Equatable{
  final int id;
  final String userName;

  UserEntity({@required this.id, @required this.userName,});
  UserEntity.Object({this.id = 0, @required this.userName,});
  @override
  List<Object> get props => [id,userName];

}