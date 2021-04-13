import 'package:equatable/equatable.dart';

class LoginEntity extends Equatable {
  final int id;
  final String userName;
  final String accessToken;

  LoginEntity({required this.id,required this.userName,required this.accessToken});


  Map<String, dynamic> toJson() => {
    'id' : id ,
    'username': userName,
    'access_token' : accessToken ,
  };

  @override
  List<Object> get props => [id,  accessToken, userName];

  @override
  String toString() {
    return 'LoginEntity{id: $id, name: $userName, accessToken: $accessToken}';
  }
}