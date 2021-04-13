import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../../../core/common/constants.dart';
import '../../../../core/widgets/dropdown_field.dart';
import '../../../../core/widgets/single_filed.dart';

// ignore: must_be_immutable
class SingleForm extends StatelessWidget {
  final bool isFirst;
  VoidCallback? onDelete;

  SingleForm({Key? key, this.isFirst = false}) : super(key: key);

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
                SingleField(label: 'Tên sản phẩm', width: size.width / 5 -20, small: true,),
                DropdownField(label: 'Ngành hàng', width: size.width / 9 -20 ,small: true,),
                SingleField(label: 'Số lượng', width: size.width / 12 - 20, small: true,),
                SingleField(label: 'Đơn vị tính', width: size.width / 12 - 20, small: true,),
                SingleField(label: 'Đơn giá', width: size.width / 12 - 20, small: true,),
                SingleField(label: 'Tổng tiền', width: size.width / 12 - 20, small: true, disable: true,),
              ],
            ),
            const SizedBox(height: 17,),
            !isFirst ? Align(
              alignment: Alignment.bottomRight,
              child: InkWell(
                  onTap: onDelete??(){},
                  child: Text('Xóa sản phẩm', style: kRedSmallText,)),
            ): const SizedBox(),
            const SizedBox(height: 19.0,),
          ],
        ),
      ),
    );
  }
}
