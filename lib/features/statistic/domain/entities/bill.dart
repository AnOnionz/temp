import 'package:equatable/equatable.dart';

class BillEntity extends Equatable {
  final int id;
  final String outletCode;
  final String outletName;
  final String token;
  final int totalBill;
  final String userName;
  final String doneAt;
  final int status;

  BillEntity({required this.id, required this.outletCode, required this.outletName, required this.token, required this.totalBill, required this.userName, required this.doneAt, required this.status});

  @override
  List<Object?> get props => [
    id
  ];


}