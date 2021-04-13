import 'package:flutter/material.dart';
import '../../../../core/common/constants.dart';

class BottomButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 88,
      decoration: BoxDecoration(
        color: kGreyColor.withOpacity(0.1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
        InkWell(
          onTap: (){

          },
          child: Container(
              width: 200,
              height: 44,
              child: Center(child: Text('Bỏ qua', style: kBlackSmallText,)),
          ),
        ),
          InkWell(
            onTap: (){

            },
            child: Container(
              width: 200,
              height: 44,
              child: Center(child: Text('Báo lỗi hình', style: kBlackSmallText,)),
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: ElevatedButton(
              onPressed: (){},
              child:
              Text('Lưu & Tiếp tục', style: kWhiteSmallText,),
              style: ElevatedButton.styleFrom(
                  primary: kGreenColor, // background
                  onPrimary: kGreenColor.withOpacity(0.3),
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16) // foreground
              ),
            ),
          ),
        ],
      ),
    );
  }
}
