import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sp_bill/core/widgets/date_time_field.dart';
import 'package:sp_bill/core/widgets/dropdown_field.dart';
import 'package:sp_bill/core/widgets/hover_button.dart';
import 'package:sp_bill/features/statistic/domain/entities/outlet.dart';
import 'package:sp_bill/features/statistic/domain/entities/user.dart';
import 'package:sp_bill/features/statistic/presentation/bloc/users_cubit.dart';
import '../../../../core/common/constants.dart';
import '../../../../core/widgets/data_table.dart';
import '../../../../core/widgets/nav.dart';
import '../../../../core/widgets/tab_title.dart';
import '../../../../di.dart';
import '../../../../responsive.dart';


class Users extends StatefulWidget {

  @override
  _UsersState createState() => _UsersState();
}

class _UsersState extends State<Users> {
  late final UsersCubit usersCubit = sl<UsersCubit>();
  late final int selectedItem;
    @override
  void initState() {
    super.initState();
    usersCubit.fetchUsers();
  }
  final data = [
    Outlet(id: '131132323', outletName: 'Co.op Đế Thần Sơn', outletCode: '48353724', totalBill: 12, billCompletedCount: 7, billNoCompletedCount: 5),
    Outlet(id: '131132323', outletName: 'Co.op Đế Thần Sơn', outletCode: '48353724', totalBill: 12, billCompletedCount: 7, billNoCompletedCount: 5),
    Outlet(id: '131132323', outletName: 'Co.op Đế Thần Sơn', outletCode: '48353724', totalBill: 12, billCompletedCount: 7, billNoCompletedCount: 5),
    Outlet(id: '131132323', outletName: 'Co.op Đế Thần Sơn', outletCode: '48353724', totalBill: 12, billCompletedCount: 7, billNoCompletedCount: 5),
    Outlet(id: '131132323', outletName: 'Co.op Đế Thần Sơn', outletCode: '48353724', totalBill: 12, billCompletedCount: 7, billNoCompletedCount: 5),
    Outlet(id: '131132323', outletName: 'Co.op Đế Thần Sơn', outletCode: '48353724', totalBill: 12, billCompletedCount: 7, billNoCompletedCount: 5),
    Outlet(id: '131132323', outletName: 'Co.op Đế Thần Sơn', outletCode: '48353724', totalBill: 12, billCompletedCount: 7, billNoCompletedCount: 5),
    Outlet(id: '131132323', outletName: 'Co.op Đế Thần Sơn', outletCode: '48353724', totalBill: 12, billCompletedCount: 7, billNoCompletedCount: 5),
    Outlet(id: '131132323', outletName: 'Co.op Đế Thần Sơn', outletCode: '48353724', totalBill: 12, billCompletedCount: 7, billNoCompletedCount: 5),
    Outlet(id: '131132323', outletName: 'Co.op Đế Thần Sơn', outletCode: '48353724', totalBill: 12, billCompletedCount: 7, billNoCompletedCount: 5),
    Outlet(id: '131132323', outletName: 'Co.op Đế Thần Sơn', outletCode: '48353724', totalBill: 12, billCompletedCount: 7, billNoCompletedCount: 5),
    Outlet(id: '131132323', outletName: 'Co.op Đế Thần Sơn', outletCode: '48353724', totalBill: 12, billCompletedCount: 7, billNoCompletedCount: 5),
    Outlet(id: '131132323', outletName: 'Co.op Đế Thần Sơn', outletCode: '48353724', totalBill: 12, billCompletedCount: 7, billNoCompletedCount: 5),

  ];

  final _header = {
    '#' : 15,
    'User' : 7,
    'Thời gian nhập phiếu': 7,
    'Số phiếu đã nhập liệu' :7,
    'Số phiếu lỗi hình' : 7,
    'Số phiếu thiếu thông tin' : 7,
    '': 15,
  };

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return
      MultiBlocProvider(
        providers: [
          BlocProvider<UsersCubit>(create: (_) => sl<UsersCubit>()),
        ], child: Responsive(
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
                    TabTitle(text: 'Thống kê số phiếu đã nhập của user'.toUpperCase()),
                    Padding(
                      padding: const EdgeInsets.only(top: 55),
                      child: FractionallySizedBox(
                        widthFactor: 3/9,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            BlocBuilder<UsersCubit, FetchUsersState>(builder: (context, state) {
                              if(state is FetchUsersLoaded){
                                selectedItem = 0;
                                return DropdownField(label: 'User',width: size.width/8, data: state.users..insert(0, UserEntity.Object(userName: 'Tất cả')),);
                              }
                              return DropdownField(label: 'User',width: size.width/8, data: [],);
                            },),
                            DateTimeField(label: 'Ngày',width: size.width/8),
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
                      label: 'Tổng số phiếu đã nhập liệu: ',
                      value: 1213,
                      labelStyle: kBlackBigText,
                      valueStyle: kRedBigText,
                      maxHeight: size.height * 0.6, headerData: _header, body:
                    ListView.separated(
                      separatorBuilder: (context, index) => Divider(color: kGreyColor,),
                      itemBuilder:(context, index) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 7.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                width: size.width /15,
                                child: Text('${index +1}')),
                            Container( width: size.width /7, child: Text(data[index].id, style: kBlackSmallText,)),
                            Container( width: size.width /7, child: Text(data[index].outletCode, style: kBlackSmallText,)),
                            Container( width: size.width /7, child: Text(data[index].billNoCompletedCount.toString(), style: kBlackSmallText,)),
                            Container( width: size.width /7, child: Text(data[index].billNoCompletedCount.toString(), style: kBlackSmallText,)),
                            Container( width: size.width /7, child: Text(data[index].billNoCompletedCount.toString(), style: kBlackSmallText,)),
                            Container( width: size.width/15, child: Center(child:
                            HoverButton(
                              onPressed: (){
                                Modular.to.pushNamed('/statistic/${data[index].id}');
                              },
                              icon: Image.asset('assets/images/asign.png', height: 16, width: 16,),
                              onActive: Image.asset('assets/images/asign_hover.png', height: 16, width: 16,),
                            ),
                            )
                            ),
                          ],
                        ),
                      ),
                      itemCount: data.length,
                      shrinkWrap: true,
                    ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      )
      );

  }
}
