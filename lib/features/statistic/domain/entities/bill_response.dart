import 'package:sp_bill/features/statistic/data/model/bill_model.dart';

class BillResponse {
  final List<BillModel> bills;
  final int totalPage;
  final int currentPage;

  BillResponse({required this.bills, required this.totalPage, required this.currentPage});
}