import 'package:flutter/material.dart';
import 'package:sp_bill/features/statistic/domain/entities/user.dart';
import '../../core/common/constants.dart';

class DropdownField extends StatefulWidget {
  final String label;
  final double width;
  final bool small;
  final List<UserEntity>? data;
  int? selectedID;

  DropdownField(
      {Key? key,
      required this.label,
      required this.width,
      this.selectedID = 0,
      this.small = false,
      this.data})
      : super(key: key);

  @override
  _DropdownFieldState createState() => _DropdownFieldState();
}

class _DropdownFieldState extends State<DropdownField> {

   dynamic selectedItem ;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
          initialValue: widget.data!.isNotEmpty ? 'Tất cả' : 'Không có user',
          builder: (FormFieldState<String> state) {
            return InputDecorator(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
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
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  icon: Icon(Icons.keyboard_arrow_down),
                  value: selectedItem,
                  isDense: true,
                  onChanged: (String? newValue) {
                    setState(() {
                      if(newValue!=null) {
                        selectedItem = newValue;
                        widget.selectedID = int.parse(newValue);
                        state.didChange(newValue);
                      }
                    });
                  },
                  items: widget.data!.map((UserEntity user) {
                    return DropdownMenuItem<String>(
                      value: user.id.toString(),
                      child: Text(user.userName),
                    );
                  }).toList(),
                ),
              ),
            );
          },
        ),
      )
    ]));
  }
}
