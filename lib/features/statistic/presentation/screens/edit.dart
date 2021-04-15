import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sp_bill/features/login/presentation/blocs/authentication_bloc.dart';
import 'package:sp_bill/features/statistic/presentation/bloc/bill_detail_cubit.dart';
import 'package:sp_bill/features/statistic/presentation/widgets/bill_input_form.dart';
import 'package:sp_bill/features/statistic/presentation/widgets/form_info.dart';
import 'package:sp_bill/features/statistic/presentation/widgets/image_view.dart';
import '../../../../core/common/constants.dart';
import '../../../../core/widgets/nav.dart';
import '../../../../responsive.dart';

class Edit extends StatefulWidget {
  final String token;

  const Edit({Key? key, required this.token}) : super(key: key);

  @override
  _EditState createState() => _EditState();
}

class _EditState extends State<Edit> {
  late List<String> images = [];
  late BillDetailCubit billDetailCubit = Modular.get<BillDetailCubit>();

  @override
  void initState() {
    billDetailCubit.fetchDetail(token: widget.token);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Responsive(
      mobile: Container(),
      tablet: Container(),
      desktop: Column(
        children: [
          NavBar(
            userName: (Modular.get<AuthenticationBloc>().state as AuthenticationAuthenticated).user.userName,
            index: 5,
          ),
          BlocBuilder<BillDetailCubit, BillDetailState>(
            bloc: billDetailCubit,
            builder: (context, state) {
              if(state is BillDetailLoaded){
                images = state.detail.imageUrls.map((e) => e.toString()).toList();
                return Expanded(
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
                        flex: 2,
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
                                          'Chỉnh sửa phiếu mua'.toUpperCase(),
                                          style: kTabTitleText,
                                        ),
                                      ),
                                    ),
                                    FormInfo(
                                      billId: state.detail.id,
                                      outletCode: state.detail.outletCode,
                                      totalPrice: state.detail.totalBill,
                                    ),
                                    BillInputForm(
                                      data: state.detail.detail,
                                    ),
                                    Spacer(),
                                  ],
                                ),
                              ),
                            ),
                            // Container(
                            //   height: 88,
                            //   decoration: BoxDecoration(
                            //     color: kGreyColor.withOpacity(0.1),
                            //   ),
                            //   child: Row(
                            //     crossAxisAlignment: CrossAxisAlignment.center,
                            //     children: [
                            //       InkWell(
                            //         onTap: () {},
                            //         child: Container(
                            //           width: 200,
                            //           height: 44,
                            //           child: Center(
                            //               child: Text(
                            //                 'Báo hình lỗi',
                            //                 style: kBlackSmallText,
                            //               )),
                            //         ),
                            //       ),
                            //       const Spacer(),
                            //       Padding(
                            //         padding:
                            //         const EdgeInsets.symmetric(horizontal: 30),
                            //         child: ElevatedButton(
                            //           onPressed: () {},
                            //           child: Text(
                            //             'Lưu',
                            //             style: kWhiteSmallText,
                            //           ),
                            //           style: ElevatedButton.styleFrom(
                            //               primary: kGreenColor, // background
                            //               onPrimary: kGreenColor.withOpacity(0.3),
                            //               elevation: 0,
                            //               padding: const EdgeInsets.symmetric(
                            //                   horizontal: 60,
                            //                   vertical: 16) // foreground
                            //           ),
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // )
                          ],
                        ),
                        flex: 3,
                      ),
                    ],
                  ),
                );
              }
              return Expanded(child: Center(child: Container(height: 60, width: 60, child: CircularProgressIndicator(),),));
            },
          ),
        ],
      ),
    );
  }
}
