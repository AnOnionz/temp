import 'package:flutter/material.dart';
import 'package:sp_bill/features/statistic/domain/entities/bill.dart';
import 'package:sp_bill/features/statistic/presentation/widgets/bill_input_form.dart';
import 'package:sp_bill/features/statistic/presentation/widgets/form_info.dart';
import 'package:sp_bill/features/statistic/presentation/widgets/image_view.dart';
import '../../../../core/common/constants.dart';
import '../../../../core/widgets/nav.dart';

import '../../../../responsive.dart';

class Edit extends StatelessWidget {
  final String id;

  const Edit({Key? key, required this.id}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final List<String> images = [
      'https://blog.onshop.asia/wp-content/uploads/2020/09/chi-phi-duy-tri-website.jpg',
      'https://blog.onshop.asia/wp-content/uploads/2020/09/How-to-Create-A-Website-From-Scratch-The-Beginner%E2%80%99s-Guide-1.jpg  ',
      'https://blog.onshop.asia/wp-content/uploads/2020/09/chi-phi-duy-tri-website1-compressed-768x512.jpg',
      'https://blog.onshop.asia/wp-content/uploads/2020/09/chi-phi-duy-tri-website2.jpg',
      'https://blog.onshop.asia/wp-content/uploads/2020/09/ssl-1.jpg',
    ];
    return Responsive(
      mobile: Container(),
      tablet: Container(),
      desktop: Column(
        children: [
          NavBar(
            userName: 'Thong',
            index: 5,
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    color: kImageBackgroundColor,
                    child: Center(
                      child: ImageView(images: images),
                    ),
                  ),
                  flex: 1,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 38.0, left: 38.0, right: 38.0),
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.topCenter,
                                child: Container(
                                  child: Text(
                                    'nhập phiếu mua'.toUpperCase(),
                                    style: kTabTitleText,
                                  ),
                                ),
                              ),
                              FormInfo(
                                bill: Bill(
                                    id: '312321',
                                    outletCode: '3203332321',
                                    totalPrice: '15.000.000',
                                    user: 'KhiemDang',
                                    createAt: '10/4/2021 8:30',
                                    status: NO_INPUT),
                              ),
                              BillInputForm(
                                data: 'đổ data',
                              ),
                              Spacer(),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 88,
                        decoration: BoxDecoration(
                          color: kGreyColor.withOpacity(0.1),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {},
                              child: Container(
                                width: 200,
                                height: 44,
                                child: Center(
                                    child: Text(
                                  'Báo hình lỗi',
                                  style: kBlackSmallText,
                                )),
                              ),
                            ),
                            const Spacer(),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30),
                              child: ElevatedButton(
                                onPressed: () {},
                                child: Text(
                                  'Lưu',
                                  style: kWhiteSmallText,
                                ),
                                style: ElevatedButton.styleFrom(
                                    primary: kGreenColor, // background
                                    onPrimary: kGreenColor.withOpacity(0.3),
                                    elevation: 0,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 60,
                                        vertical: 16) // foreground
                                    ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  flex: 2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
