import 'package:sp_bill/features/statistic/domain/entities/bill.dart';
import 'package:flutter/foundation.dart';
class BillModel extends BillEntity {
  BillModel({
    @required int id,
    @required String outletName,
    @required String outletCode,
    @required String token,
    @required int totalBill,
    @required String userName,
    @required int status,
    @required String doneAt,
  }) : super(
          id: id,
          userName: userName,
          outletName: outletName,
          outletCode: outletCode,
          token: token,
          totalBill: totalBill,
          doneAt: doneAt,
          status: status,
        );

  factory BillModel.fromJson(Map<String, dynamic> json) {
    return BillModel(
        id: json['bill_id'],
        outletName: json['outlet_name'],
        outletCode: json['outlet_code'],
        token: json['bill_token'],
        totalBill: json['total_bill'],
        userName: json['username'],
        status: json['status'],
        doneAt: json['done_at']);
  }
}
