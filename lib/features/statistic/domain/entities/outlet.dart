class Outlet{
  final String id;
  final String outletName;
  final String outletCode;
  final int totalBill;
  final int billCompletedCount;
  final int billNoCompletedCount;
  final int? status;

  Outlet({this.status, required this.id,required this.outletName,required this.outletCode, required this.totalBill,required this.billCompletedCount,required this.billNoCompletedCount});


}