import 'package:flutter/material.dart';
import 'package:sp_bill/core/common/constants.dart';


class UtilButton extends StatelessWidget {
  final Widget icon;
  final VoidCallback callback;

  const UtilButton({Key key, @required this.icon, @required this.callback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
      child: InkWell(
        onTap: callback,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 4.0),
          decoration: BoxDecoration(
              color: kGreyColor.withOpacity(0.3),
              borderRadius: BorderRadius.circular(5.0),
            border: Border.all(
              color: kGreyColor,
            )
          ),
          child: icon,
        ),
      ),
    );
  }
}
