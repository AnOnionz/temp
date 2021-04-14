import 'package:flutter/material.dart';
import 'package:sp_bill/core/common/constants.dart';


class StatusBill extends StatelessWidget {
  final int status;
  String wStatusText(){
    switch (this.status){
      case 6: return 'Hoàn Thành';
      case 5: return 'Lỗi hình';
      case 4: return 'Thiếu dữ liệu';
      case 1:
      case 2:
      case 3: return 'Chưa nhập';
    }
    return 'Không xác định';
  }
  Color wStatusColor(){
    switch (this.status){
      case 6: return kGreenColor;
      case 5: return kRedColor;
      case 4: return kAmberColor;
      case 1:
      case 2:
      case 3: return Colors.black87;
    }
    return Colors.black87;
  }
  const StatusBill({Key? key, required this.status}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
          Image.asset('assets/images/${status==1 || status ==2 || status ==3 ? 0 : status}.png', height: 20,),
          const SizedBox(width: 9.0,),
          Text(wStatusText(), style: TextStyle(fontSize: 15, color: wStatusColor()),)

      ],
    );
  }
}

