import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sp_bill/core/widgets/date_time_field.dart';
import 'package:sp_bill/core/widgets/dropdown_field.dart';
import 'package:sp_bill/core/widgets/hover_button.dart';
import 'package:sp_bill/core/widgets/single_filed.dart';
import 'package:sp_bill/features/statistic/domain/entities/bill.dart';
import 'package:sp_bill/features/statistic/presentation/widgets/status_bill.dart';
import '../../../../core/common/constants.dart';
import '../../../../core/widgets/data_table.dart';
import '../../../../core/widgets/nav.dart';
import '../../../../core/widgets/tab_title.dart';
import '../../../../responsive.dart';


class Bills extends StatelessWidget {
  final String id;

  final bills = [
    Bill(id: '312321', outletCode: '3203332321', totalPrice: '15.000.000', user: 'KhiemDang', createAt: '10/4/2021 8:30', status: SUCCESS),
    Bill(id: '312321', outletCode: '3203332321', totalPrice: '15.000.000', user: 'KhiemDang', createAt: '10/4/2021 8:30', status: SUCCESS),
    Bill(id: '312321', outletCode: '3203332321', totalPrice: '15.000.000', user: 'KhiemDang', createAt: '10/4/2021 8:30', status: SUCCESS),
    Bill(id: '312321', outletCode: '3203332321', totalPrice: '15.000.000', user: 'KhiemDang', createAt: '10/4/2021 8:30', status: IMAGE_FAIL),
    Bill(id: '312321', outletCode: '3203332321', totalPrice: '15.000.000', user: 'KhiemDang', createAt: '10/4/2021 8:30', status: OWE_DATA),
    Bill(id: '312321', outletCode: '3203332321', totalPrice: '15.000.000', user: 'KhiemDang', createAt: '10/4/2021 8:30', status: NO_INPUT),
    Bill(id: '312321', outletCode: '3203332321', totalPrice: '15.000.000', user: 'KhiemDang', createAt: '10/4/2021 8:30', status: SUCCESS),
    Bill(id: '312321', outletCode: '3203332321', totalPrice: '15.000.000', user: 'KhiemDang', createAt: '10/4/2021 8:30', status: SUCCESS),
    Bill(id: '312321', outletCode: '3203332321', totalPrice: '15.000.000', user: 'KhiemDang', createAt: '10/4/2021 8:30', status: NO_INPUT),
    Bill(id: '312321', outletCode: '3203332321', totalPrice: '15.000.000', user: 'KhiemDang', createAt: '10/4/2021 8:30', status: NO_INPUT),
    Bill(id: '312321', outletCode: '3203332321', totalPrice: '15.000.000', user: 'KhiemDang', createAt: '10/4/2021 8:30', status: SUCCESS),
    Bill(id: '312321', outletCode: '3203332321', totalPrice: '15.000.000', user: 'KhiemDang', createAt: '10/4/2021 8:30', status: SUCCESS),
    Bill(id: '312321', outletCode: '3203332321', totalPrice: '15.000.000', user: 'KhiemDang', createAt: '10/4/2021 8:30', status: NO_INPUT),

  ];

  final _header = {
    '#' : 25,
    'ID phiếu' : 10,
    'Outlet Code': 10,
    'Outlet Name': 7,
    'Tổng tiền' : 10,
    'User nhập liệu': 10,
    'Thời gian nhập' : 10,
    'Tình trạng' : 10,
    '': 25,
  };

  Bills({Key? key,required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Responsive(
      mobile: Container(),
      tablet: Container(),
      desktop: Column(
        children: [
          NavBar(userName:'Thong',index: 5,),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 38.0, right: 38.0, left: 38.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TabTitle(text: 'phân bổ phiếu mua'.toUpperCase()),
            Padding(
              padding: const EdgeInsets.only(top: 55),
              child: FractionallySizedBox(
                widthFactor: 6/8,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SingleField(label: 'ID phiếu', width: size.width/8,),
                    SingleField(label: 'Outlet code',width: size.width/8),
                    DropdownField(label: 'User nhập liệu',width: size.width/8,),
                    DateTimeField(label: 'Ngày nhập liệu',width: size.width/8),
                    DropdownField(label: 'Tình trạng',width: size.width/8,),
                    ElevatedButton(
                      onPressed: (){},
                      child:
                      Text('Tìm', style: kBlackSmallText,),
                      style: ElevatedButton.styleFrom(
                          primary: kGreyColor, // background
                          onPrimary: kGreenColor,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16) // foreground
                      ),
                    ),
                  ],
                ),
              ),
            ),
                  JDataTable(
                    label: 'Kết quả: ',
                    value: 27,
                    labelStyle: kRedText,
                    valueStyle: kRedText,
                    maxHeight: size.height * 0.6, headerData: _header, body:
                  ListView.separated(
                    separatorBuilder: (context, index) => Divider(color: kGreyColor,),
                    itemBuilder:(context, index) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 7.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              width: size.width /25,
                              child: Text('${index +1}')),
                          Container( width: size.width /10, child: Text(bills[index].id, style: kBlackSmallText,)),
                          Container( width: size.width /10, child: Text(bills[index].outletCode, style: kBlackSmallText,)),
                          Container( width: size.width /7, child: Text(bills[index].outletCode, style: kBlackSmallText,)),
                          Container( width: size.width /10, child: Text(bills[index].totalPrice, style: kBlackSmallText,)),
                          Container( width: size.width /10, child: Text(bills[index].outletCode, style: kBlackSmallText,)),
                          Container( width: size.width /10, child: Text(bills[index].createAt, style: kBlackSmallText,)),
                          Container( width: size.width /10, child: StatusBill(status:bills[index].status)),
                          Container( width: size.width/25, child: Center(child:
                          HoverButton(
                            onPressed: (){
                              Modular.to.pushNamed('/statistic/${bills[index].id}/edit');
                            },
                            icon: Image.asset('assets/images/edit.png', height: 16, width: 16,),
                            onActive: Image.asset('assets/images/edit_hover.png', height: 16, width: 16,),
                          ),
                          )
                          ),
                        ],
                      ),
                    ),
                    itemCount: bills.length,
                    shrinkWrap: true,
                  ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
