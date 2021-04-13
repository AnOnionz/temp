import 'package:equatable/equatable.dart';

class UserEntity extends Equatable{
  final int id;
  final String userName;
  final int total;
  final int done;

  UserEntity({required this.id, required this.userName, required this.total, required this.done});
  UserEntity.Object({this.id = 0, required this.userName, this.total = 0, this.done = 0});
  @override
  List<Object?> get props => [id,userName, total, done];

}