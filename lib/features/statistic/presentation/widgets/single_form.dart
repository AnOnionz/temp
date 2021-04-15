import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sp_bill/core/utils/string_tranform.dart';
import 'package:sp_bill/features/statistic/domain/entities/industry.dart';
import '../../../../core/widgets/single_filed.dart';

// ignore: must_be_immutable
class SingleForm extends StatelessWidget {
  final IndustryEntity industry;

  SingleForm({Key? key, required this.industry}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final size =MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.only(top: size.height/35),
      child: Container(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SingleField(label: 'Tên sản phẩm', width: size.width / 5 -20, small: true, disable:true, initValue: industry.productName,),
                // DropdownField(label: 'Ngành hàng', width: size.width / 9 -20 ,small: true,
                //   child: DropdownButtonHideUnderline(
                //     child: DropdownButton<String>(
                //       icon: Icon(Icons.keyboard_arrow_down),
                //       value: selectedUser,
                //       isDense: true,
                //       onChanged: (String? newValue) {
                //         setState(() {
                //           if(newValue!=null) {
                //             selectedUser = newValue;
                //           }
                //         });
                //       },
                //       items:state.users.map((UserEntity user) {
                //         return DropdownMenuItem<String>(
                //           value: user.id.toString(),
                //           child: Text(user.userName),
                //           onTap: () {
                //             setState(() {
                //               selectedId = user.id;
                //             });
                //           },
                //         );
                //       }).toList(),
                //     ),
                //   ),),
                SingleField(label: 'Số lượng', width: size.width / 12 - 20, small: true,disable: true,initValue: industry.qty==null?'':industry.qty.toString()),
                SingleField(label: 'Đơn vị tính', width: size.width / 12 - 20, small: true,disable: true,initValue: industry.unit??'',),
                SingleField(label: 'Đơn giá', width: size.width / 12 - 20, small: true,disable:true,initValue: industry.unitPrince==null ? "" : industry.unitPrince.toString() ,),
                SingleField(label: 'Tổng tiền', width: size.width / 12 - 20, small: true, disable: true, initValue: industry.unitPrince==null || industry.qty==null ? "" : displayPrice(industry.unitPrince! * industry.qty!,)),
              ],
            ),
            const SizedBox(height: 19.0,),
          ],
        ),
      ),
    );
  }
}
