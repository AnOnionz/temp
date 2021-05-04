import 'package:flutter/material.dart';
import 'package:sp_bill/features/statistic/domain/entities/user.dart';
import '../../core/common/constants.dart';

class DropdownField extends StatefulWidget {
  final String label;
  final double width;
  final bool small;
  final bool disable;
  final Widget child;

  DropdownField(
      {Key key,
      @required this.label,
      @required this.width,
      this.small = false,
      this.disable = false,
      @required this.child})
      : super(key: key);

  @override
  _DropdownFieldState createState() => _DropdownFieldState();
}

class _DropdownFieldState extends State<DropdownField> {
  dynamic selectedItem;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Container(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          widget.label,
          style: widget.small ? kBlackSmallSmallText : kBlackSmallText,
        ),
        const SizedBox(
          height: 4.0,
        ),
        Container(
          height: 37,
          width: widget.width,
          child: FormField<String>(
            enabled: !widget.disable,
            builder: (FormFieldState<String> state) {
              return InputDecorator(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 10.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: BorderSide(
                        color: kGreyColor.withOpacity(0.5),
                        width: 1,
                      )),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: BorderSide(
                        color: kGreyColor,
                        width: 1,
                      )),
                ),
                isEmpty: selectedItem == '',
                child: widget.child,
              );
            },
          ),
        )
      ])),
    );
  }
}
