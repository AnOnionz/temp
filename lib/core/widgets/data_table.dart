import 'package:flutter/material.dart';

import 'header.dart';

class JDataTable extends StatelessWidget {
  final Map<String, num> headerData;
  final Widget body;
  final double maxHeight;
  final String label;
  final int value;
  final TextStyle labelStyle;
  final TextStyle valueStyle;


  const JDataTable(
      {Key key,
      @required this.headerData,
      @required this.body,
      @required this.maxHeight,
       this.label,
        this.labelStyle,
        this.value,
        this.valueStyle,

      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.max,
      children: [
        label != null ? Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 33.0),
              child: RichText(
                text: TextSpan(
                    children: [
                      TextSpan(text: '$label',style: labelStyle),
                      TextSpan(text: '$value',style: valueStyle),
                    ]
                ),

              ),
            )):
        const SizedBox(
          height: 45,
        ),
        Header(headerData: headerData),
        Container(
            constraints: BoxConstraints(
                maxHeight: maxHeight),
            child: body),
      ],
    );
  }
}
