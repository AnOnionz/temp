class ExcelEntity {
  final int id;
  final String outletCode;
  final String channel;
  final String outletName;
  final String province;
  final String industryName;
  final String totalBill;
  final String productName;
  final int qty;
  final String unit;
  final String unitPrice;
  final String totalMoney;
  final String note;
  final String createBy;
  final String createAt;

  ExcelEntity({this.id, this.outletCode, this.channel, this.outletName, this.province, this.industryName, this.totalBill, this.productName, this.qty, this.unit, this.unitPrice, this.totalMoney, this.note, this.createBy, this.createAt});

  Map<String, dynamic> toJson(){
    return {
      "bill_id": id,
      "outlet_code": outletCode,
      "channel": channel,
      "outlet_name": outletName,
      "province": province,
      "industry_name": industryName,
      "total_bill": totalBill,
      "product_name": productName,
      "qty": qty,
      "unit": unit,
      "unit_price": unitPrice,
      "total_money": totalMoney,
      "note": note,
      "created_by": createBy,
      "created_at": createAt
    };
  }
}