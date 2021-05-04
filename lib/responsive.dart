import 'package:essential_xlsx/essential_xlsx.dart';
import 'package:flutter/material.dart';


String _mappingTitle(String title){
  switch(title){
    case 'channel' : return '';
    case 'bill_id' : return 'Bill ID';
    case 'outlet_code' : return 'Outlet Code';
    case 'outlet_name' : return 'Outlet Name';
    case 'province' : return 'Province';
    case 'industry_name': return 'Ngành Hàng';
    case 'total_bill' : return 'TỔNG GIÁ TRỊ CỦA TOÀN BILL';
    case 'product_name' : return 'Tên sản phẩm';
    case 'qty': return 'Số lượng';
    case 'unit' : return 'Đơn vị tính';
    case 'unit_price' : return 'Đơn giá';
    case 'total_money' : return 'Tổng tiền';
    case 'note': return 'Ghi Chú';
    case 'created_by' : return 'Nhân Viên Nhập';
    case ' created_at' : return 'Ngày Nhập';
    default: return title;
  }


}
Future<void> exportExcel({@required List<Map<String, dynamic>> data, String name}) async {
  if (data != null && data.isNotEmpty) {
    if (data.isNotEmpty) {
      var excel = SimpleXLSX();
      excel.sheetName = 'sheet';
      excel.fileName = name;
      //add data
      var idx = 0;
      data.forEach((item) {
        if (idx == 0) {
          //add titles
          excel.addRow(item.keys.toList().map((e) => _mappingTitle(e)).toList());
        }
        {
          //add values
          excel.addRow(item.values.map((i) => i.toString()).toList());
        }
        idx++;
      });

      excel.build();
    }
  }
}

class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;
  final Widget desktop;

  const Responsive({
    Key key,
    @required this.mobile,
    @required this.tablet,
    @required this.desktop,
  }) : super(key: key);

// This size work fine on my design, maybe you need some customization depends on your design

  // This isMobile, isTablet, isDesktop helep us later
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 650;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width < 1280 &&
          MediaQuery.of(context).size.width >= 650;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1280;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      // If our width is more than 1100 then we consider it a desktop
      builder: (context, constraints) {
        if (constraints.maxWidth >= 1280) {
          return desktop;
        }
        // If width it less then 1100 and more then 650 we consider it as tablet
        else if (constraints.maxWidth >= 650) {
          return tablet;
        }
        // Or less then that we called it mobile
        else {
          return mobile;
        }
      },
    );
  }
}