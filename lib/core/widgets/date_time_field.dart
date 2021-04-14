import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../core/common/constants.dart';

class DateTimeField extends StatefulWidget {
  final String label;
  final double width;
  final VoidCallback onTap;
  final TextEditingController controller;

  const DateTimeField({Key? key, required this.label, required this.width, required this.onTap, required this.controller})
      : super(key: key);

  @override
  _DateTimeFieldState createState() => _DateTimeFieldState();
}

class _DateTimeFieldState extends State<DateTimeField> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          widget.label,
          style: kBlackSmallText,
        ),
        const SizedBox(
          height: 4.0,
        ),
        Container(
          height: 37,
          width: widget.width,
          child: TextFormField(
            readOnly: true,
            style: TextStyle(
              fontSize: 15
            ),
            controller: widget.controller,
            onTap: widget.onTap,
            decoration: InputDecoration(
              filled: true,
              fillColor:  Colors.white,
              suffixIcon: Icon(Icons.date_range_outlined, size: 25, color: Colors.black45,),
              contentPadding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: BorderSide(
                    color: kGreyColor.withOpacity(0.3),
                    width: 1,
                  )
              ),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: BorderSide(
                    color: kGreyColor,
                    width: 1,
                  )
              ),
              errorBorder:OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: BorderSide(
                    color: Colors.redAccent,
                    width: 1,
                  )
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
