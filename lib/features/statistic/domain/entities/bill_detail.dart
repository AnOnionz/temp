import 'package:equatable/equatable.dart';

class BillDetailEntity extends Equatable{
  final int id;
  final String billNUmber;
  final int totalBill;
  final String outletCode;
  final String outletName;
  final List<String> imageUrls;
  final String token;
  final List<dynamic> detail;

  BillDetailEntity({required this.id,required this.token, required this.billNUmber, required this.totalBill, required this.outletCode, required this.outletName, required this.imageUrls, required this.detail});
  @override
  List<Object?> get props => [id];

}