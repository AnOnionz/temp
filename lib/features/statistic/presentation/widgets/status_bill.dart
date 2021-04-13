import 'package:flutter/material.dart';
import 'package:sp_bill/core/common/constants.dart';


class StatusBill extends StatelessWidget {
  final int status;
  String wStatusText(){
    switch (this.status){
      case 1: return 'Hoàn Thành';
      case 2: return 'Lỗi hình';
      case 3: return 'Thiếu dữ liệu';
      case 0: return 'Chưa nhập';
    }
    return 'Không xác định';
  }
  Color wStatusColor(){
    switch (this.status){
      case 1: return kGreenColor;
      case 2: return kRedColor;
      case 3: return kAmberColor;
      case 0: return Colors.black87;
    }
    return Colors.black87;
  }
  const StatusBill({Key? key, required this.status}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
          Image.asset('assets/images/$status.png', height: 20,),
          const SizedBox(width: 9.0,),
          Text(wStatusText(), style: TextStyle(fontSize: 15, color: wStatusColor()),)

      ],
    );
  }
}

