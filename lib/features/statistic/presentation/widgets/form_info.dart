import 'package:flutter/material.dart';
import 'package:sp_bill/core/common/constants.dart';
import 'package:sp_bill/features/statistic/domain/entities/bill.dart';

class FormInfo extends StatelessWidget {
  final BillEntity bill;

  const FormInfo({Key? key, required this.bill}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 74.0),
      child: Row(
        children: [
          Image.asset('assets/images/play.png', height: 15.4,),
          const SizedBox(width: 19.0,),
          Text('ID Phiếu: ${bill.id}',style: kBlackSmallText,),
          const SizedBox(width: 42.0,),
          Text('Outlet Code: ${bill.outletCode}',style: kBlackSmallText,),
          Spacer(),
          Text('Tổng tiền: ', style: kBlackBigText,),
          const SizedBox(width: 18.0,),
          Text('${bill.totalBill} VND', style: TextStyle(color: kRedColor, fontSize: 20),),
        ],

      ),
    );
  }
}
