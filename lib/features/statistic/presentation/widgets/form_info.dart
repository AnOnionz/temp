import 'package:flutter/material.dart';
import 'package:sp_bill/core/common/constants.dart';
import 'package:sp_bill/core/utils/string_tranform.dart';
import 'package:sp_bill/features/statistic/domain/entities/bill.dart';

class FormInfo extends StatelessWidget {
  final int billId;
  final String outletCode;
  final int totalPrice;

  const FormInfo({Key? key, required this.billId, required this.outletCode, required this.totalPrice}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 74.0),
      child: Row(
        children: [
          Image.asset('assets/images/play.png', height: 15.4,),
          const SizedBox(width: 19.0,),
          Text('ID Phiếu: $billId',style: kBlackSmallText,),
          const SizedBox(width: 42.0,),
          Text('Outlet Code: $outletCode',style: kBlackSmallText,),
          Spacer(),
          Text('Tổng tiền: ', style: kBlackBigText,),
          const SizedBox(width: 18.0,),
          Text('${displayPrice(totalPrice)} VNĐ', style: TextStyle(color: kRedColor, fontSize: 20),),
        ],

      ),
    );
  }
}
