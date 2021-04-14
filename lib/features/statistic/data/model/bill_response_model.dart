import 'package:sp_bill/features/statistic/domain/entities/bill_response.dart';

import 'bill_model.dart';

class BillResponseModel extends BillResponse {
  BillResponseModel({
    required int totalPage,
    required int currentPage,
    required List<BillModel> bills,
  }) : super(bills: bills, totalPage: totalPage, currentPage: currentPage);

  factory BillResponseModel.fromJson(Map<String, dynamic> json) {
    return BillResponseModel(
        totalPage: json['total_page'],
        currentPage: json['current_page'],
        bills: (json['data'] as List<dynamic>)
            .map((e) => BillModel.fromJson(e))
            .toList());
  }
}
