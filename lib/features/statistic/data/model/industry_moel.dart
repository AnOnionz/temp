import 'package:sp_bill/features/statistic/domain/entities/industry.dart';

class IndustryModel extends IndustryEntity {
  IndustryModel(
      {int? industryId,
      String? industryName,
       String? productName,
       int? qty,
      String? unit,
      int? unitPrince})
      : super(
            industryId: industryId,
            industryName: industryName,
            productName: productName,
            qty: qty,
            unit: unit,
            unitPrince: unitPrince);

  factory IndustryModel.fromJson(Map<String, dynamic> json) {
    return IndustryModel(
        industryId: json['industry_id'],
        industryName: json['industry_name'],
        productName: json['product_name'],
        qty: json['qty'],
        unit: json['unit'],
        unitPrince: json['unit_price']);
  }
}
