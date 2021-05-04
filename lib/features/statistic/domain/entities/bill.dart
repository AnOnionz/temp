import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class BillEntity extends Equatable {
  final int id;
  final String outletCode;
  final String outletName;
  final String token;
  final int totalBill;
  final String userName;
  final String doneAt;
  final int status;

  BillEntity({@required this.id, @required this.outletCode, @required this.outletName,@required this.token, @required this.totalBill, @required this.userName, @required this.doneAt, @required this.status});

  @override
  List<Object> get props => [
    id
  ];
  Map<String, dynamic> toJson(){
    return {
      'ID': id,
      'OutletCode': outletCode,
      'OutletName': outletName,
      'Tổng Tiền': totalBill,
      'User nhập liệu': userName,
      'Thời gian nhập': doneAt,
      'Tình trạng': wStatusText()
    };

  }
  String wStatusText(){
    switch (this.status){
      case 6: return 'Hoàn Thành';
      case 5: return 'Lỗi hình';
      case 4: return 'Thiếu dữ liệu';
      case 1:
      case 2:
      case 3: return 'Chưa nhập';
    }
    return 'Không xác định';
  }

}