import 'package:sp_bill/core/utils/string_tranform.dart';
import 'package:sp_bill/features/statistic/domain/entities/excel.dart';

class ExcelModel extends ExcelEntity {
  ExcelModel({
    int id,
    String outletCode,
    String channel,
    String outletName,
    String province,
    String industryName,
    String totalBill,
    String productName,
    int qty,
    String unit,
    String unitPrice,
    String totalMoney,
    String note,
    String createBy,
    String createAt,
  }) : super(
            id: id,
            province: province,
            unit: unit,
            qty: qty,
            productName: productName,
            industryName: industryName,
            outletName: outletName,
            outletCode: outletCode,
            totalBill: totalBill,
            createAt: createAt,
            channel: channel,
            createBy: createBy,
            note: note,
            totalMoney: totalMoney,
            unitPrice: unitPrice);

  factory ExcelModel.fromJson(Map<String, dynamic> json){
    return ExcelModel(
      id: json['bill_id'],
      outletCode: json['outlet_code'],
      channel: json['channel'],
      outletName: json['outlet_name'],
      province: json['province'],
      industryName: json['industry_name'],
      totalBill: moneyTransform(json['total_bill'] ?? 0),
      productName: json['product_name'],
      qty: json['qty'],
      unit: json['unit'],
      unitPrice: moneyTransform(json['unit_price'] ?? 0),
      totalMoney: moneyTransform(json['total_money'] ?? 0),
      note: json['note'],
      createBy: json['created_by'],
      createAt: (json['created_at'] as String).split(' ').last.split('/').sublist(0,2).map((e) => int.parse(e)).toList().join('/')
    );
  }
}
