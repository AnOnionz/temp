import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
class LoginEntity extends Equatable {
  final int id;
  final String userName;
  final String accessToken;
  final int role;

  LoginEntity({@required this.id,@required this.userName,@required this.accessToken, @required this.role});


  Map<String, dynamic> toJson() => {
    'id' : id ,
    'username': userName,
    'access_token' : accessToken ,
    'role': role,
  };

  @override
  List<Object> get props => [id,  accessToken, userName, role];

  @override
  String toString() {
    return 'LoginEntity{id: $id, name: $userName, accessToken: $accessToken, role: $role}';
  }
}