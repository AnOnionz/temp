import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../common/constants.dart';

class SingleField  extends StatelessWidget {
  final String label;
  final double width;
  final bool small;
  final bool disable;
  final TextEditingController? controller;

  const SingleField({Key? key, required this.label, required this.width, this.small = false, this.disable= false, this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: small ? kBlackSmallSmallText : kBlackSmallText ,),
          const SizedBox(height: 4.0,),
          Container(
            height: 37,
            width: width,
            child: TextFormField(
              enabled: !disable,
              controller: controller,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                suffixIcon: disable ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset('assets/images/denied.png', height: 13, width: 13,),
                ) : null,
                contentPadding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: BorderSide(
                    color: kGreyColor.withOpacity(0.9),
                    width: 1,
                    style: BorderStyle.none
                  )
                ),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(
                        color: kGreyColor,
                        width: 1,
                    )
                ),
                disabledBorder: OutlineInputBorder(
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
        ],
      ),
    );
  }
}
