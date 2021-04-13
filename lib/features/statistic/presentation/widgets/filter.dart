import 'package:flutter/material.dart';
import '../../../../core/common/constants.dart';
import '../../../../core/widgets/single_filed.dart';

class FilterCO extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size =MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(top: 55),
      child: FractionallySizedBox(
        widthFactor: 0.35,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SingleField(label: 'Outlet name', width: size.width/8,),
            SingleField(label: 'Outlet code',width: size.width/8),
            ElevatedButton(
              onPressed: (){},
              child:
              Text('Tìm', style: kBlackSmallText,),
              style: ElevatedButton.styleFrom(
                  primary: kGreyColor, // background
                  onPrimary: kGreenColor,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16) // foreground
              ),
            ),
          ],
        ),
      ),
    );
  }
}
