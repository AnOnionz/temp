import 'package:flutter/material.dart';
import '../../core/common/constants.dart';

class Header extends StatelessWidget {
  final Map<String, num> headerData ;

  const Header({Key key, @required this.headerData}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: headerData.entries.map((e) => Container( width: width /e.value, child: e.key != '' ? Text(e.key, style: kBlackSmallText,) : const SizedBox()),).toList(),
        ),
        Divider(color: kGreyColor,),
      ],
    );
  }
}
