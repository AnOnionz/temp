import 'package:sp_bill/features/statistic/data/model/industry_moel.dart';
import 'package:sp_bill/features/statistic/domain/entities/bill_detail.dart';
import 'package:sp_bill/features/statistic/domain/entities/industry.dart';
import 'package:flutter/foundation.dart';

class BillDetailModel extends BillDetailEntity{
  BillDetailModel({
    @required int id,
    @required String billNumber,
    @required int totalBill,
    @required String outletCode,
    @required String outletName,
    @required String token,
    @required List<IndustryEntity> detail,
    @required List<String> imageUrls,
}) : super(
    id: id,
    billNUmber: billNumber,
    outletCode: outletCode,
    outletName: outletName,
    totalBill: totalBill,
    token: token,
    imageUrls: imageUrls,
    detail: detail
  );
  factory BillDetailModel.fromJson(Map<String, dynamic> json){
    return BillDetailModel(
      id: json['bill_id'],
      billNumber: json['bill_number'],
      totalBill: json['total_bill'],
      token: json['bill_token'],
      outletCode: json['outlet_code'],
      outletName: json['outlet_name'],
      imageUrls: (json['images'] as List<dynamic>).map((e) => e.toString()).toList(),
      detail: (json['details'] as List<dynamic>).map((e) => IndustryModel.fromJson(e)).toList(),
    );
  }

}