import 'package:sp_bill/features/statistic/domain/entities/excel.dart';

class ExcelModel extends ExcelEntity {
  ExcelModel({
    int id,
    String outletCode,
    String chanel,
    String outletName,
    String province,
    String industryName,
    int totalBill,
    String productName,
    int qty,
    String unit,
    int unitPrice,
    int totalMoney,
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
            chanel: chanel,
            createBy: createBy,
            note: note,
            totalMoney: totalMoney,
            unitPrice: unitPrice);

  factory ExcelModel.fromJson(Map<String, dynamic> json){
    return ExcelModel(
      id: json['bill_id'],
      outletCode: json['outlet_code'],
      chanel: json['chanel'],
      outletName: json['outlet_name'],
      province: json['province'],
      industryName: json['industry_name'],
      totalBill: json['total_bill'],
      productName: json['product_name'],
      qty: json['qty'],
      unit: json['unit'],
      unitPrice: json['unit_price'],
      totalMoney: json['total_money'],
      note: json['note'],
      createBy: json['created_by'],
      createAt: json['created_at']
    );
  }

}
