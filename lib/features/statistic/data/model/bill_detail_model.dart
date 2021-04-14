import 'package:sp_bill/features/statistic/domain/entities/bill_detail.dart';

class BillDetailModel extends BillDetailEntity{
  BillDetailModel({
    required int id,
    required String billNumber,
    required int totalBill,
    required String outletCode,
    required String outletName,
    required String token,
    required List<dynamic> detail,
    required List<String> imageUrls,
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
      imageUrls: (json['images'] as List<String>),
      detail: json['details'],
    );
  }

}