import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:sp_bill/core/common/constants.dart';
import 'package:sp_bill/features/statistic/domain/entities/industry.dart';
import 'package:sp_bill/features/statistic/presentation/widgets/single_form.dart';


class BillInputForm extends StatefulWidget {
  final List<IndustryEntity> data;

  const BillInputForm({Key? key, required this.data}) : super(key: key);
  @override
  _BillInputFormState createState() => _BillInputFormState();
}

class _BillInputFormState extends State<BillInputForm> {
  ScrollController _scrollController = ScrollController();
  late final forms = widget.data.map((e) => SingleForm(industry: e)).toList();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height / 1.8),
          child: ListView.builder(
            controller: _scrollController,
            itemBuilder: (context, index) {
              return forms[index];
            },
            itemCount: forms.length,
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
          ),
        ),
        // InkWell(
        //   onTap: _addNew,
        //   child: DottedBorder(
        //     borderType: BorderType.RRect,
        //     radius: Radius.circular(5.0),
        //     strokeWidth: 2,
        //     color: kGreyColor,
        //     child: ClipRRect(
        //       borderRadius: BorderRadius.all(Radius.circular(5.0)),
        //       child: Container(
        //         padding: const EdgeInsets.symmetric(horizontal: 17),
        //         height: 37,
        //         width: double.infinity,
        //         color: kGreyColor.withOpacity(0.3),
        //         child: Row(
        //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //           children: [
        //             const SizedBox(),
        //             Center(
        //                 child: Text(
        //               'Thêm sản phẩm',
        //               style: kBlackSmallText,
        //             )),
        //             Text(
        //               'Phím tắt Alt + Enter',
        //               style: kGreySmallText,
        //             ),
        //           ],
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}

class MyIntent extends Intent {
  const MyIntent();
}
