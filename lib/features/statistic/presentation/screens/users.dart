import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:localstorage/localstorage.dart';
import 'package:sp_bill/core/common/keys.dart';
import 'package:sp_bill/core/widgets/date_time_field.dart';
import 'package:sp_bill/core/widgets/dropdown_field.dart';
import 'package:sp_bill/core/widgets/hover_button.dart';
import 'package:sp_bill/features/login/presentation/blocs/authentication_bloc.dart';
import 'package:sp_bill/features/statistic/domain/entities/user.dart';
import 'package:sp_bill/features/statistic/domain/entities/user_bill.dart';
import 'package:sp_bill/features/statistic/presentation/bloc/userbill_cubit.dart';
import 'package:sp_bill/features/statistic/presentation/bloc/users_cubit.dart';
import '../../../../core/common/constants.dart';
import '../../../../core/widgets/data_table.dart';
import '../../../../core/widgets/nav.dart';
import '../../../../core/widgets/tab_title.dart';
import '../../../../responsive.dart';


class Users extends StatefulWidget {

  @override
  _UsersState createState() => _UsersState();
}

class _UsersState extends State<Users> {
  TextEditingController _controller = TextEditingController();
  late final UsersCubit usersCubit = Modular.get<UsersCubit>();
  late final UserBillCubit userBillCubit = Modular.get<UserBillCubit>();
  DateTimeRange? _selectedDate ;
  int _selectedId = 0;
  String _selectedUser = 'Tất cả';
    @override
  void initState() {
    usersCubit.fetchUsers();
    userBillCubit.fetchUserBill(userId: 0);
    super.initState();
  }

  late List<UserBillEntity> data;

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
    return Responsive(
    mobile: Container(),
    tablet: Container(),
    desktop: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        NavBar(userName:(
            Modular.get<AuthenticationBloc>().state as AuthenticationAuthenticated).user.userName, index: 5,),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 38.0, right: 38.0, left: 38.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TabTitle(text: 'Thống kê số phiếu đã nhập của user'.toUpperCase()),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      BlocBuilder<UsersCubit, FetchUsersState>(
                        bloc: Modular.get<UsersCubit>(),
                        builder: (context, state) {
                        if(state is FetchUsersLoaded){
                          return DropdownField(
                            label: 'User',width: 230, child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: _selectedUser,
                              underline: Container(color: Colors.black, height: 3,),
                              icon: Icon(Icons.keyboard_arrow_down),
                              isDense: true,
                              onChanged: (String? newValue) {
                                setState(() {
                                  if(newValue != null) {
                                    _selectedUser = newValue;
                                  }
                                });
                              },
                              items: state.users.map((UserEntity user) {
                                return DropdownMenuItem<String>(
                                  value: user.userName,
                                  child: Text(user.userName),
                                  onTap: () {
                                    setState(() {
                                      _selectedId = user.id;
                                    });
                                  },
                                );
                              }).toList(),
                            ),
                          ),);
                        }
                        return DropdownField(label: 'User',width: 230, child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            icon: Icon(Icons.keyboard_arrow_down),
                            isDense: true,
                            onChanged: (String? newValue) {
                              setState(() {
                                if(newValue!=null) {
                                  _selectedUser = newValue;
                                }
                              });
                            },
                            items:[DropdownMenuItem<String>(
                                value: 'Tất cả',
                                child: Text('Tất cả'),
                                onTap: () {
                                  setState(() {
                                    _selectedId = 0;
                                  });
                                },
                              )],
                          ),
                        ),);
                      },),
                      const SizedBox(width: 25),
                      DateTimeField(label: 'Ngày',width: 230,controller: _controller, onTap: () async {
                            final rangeDate = await showDateRangePicker(
                            context: context,
                            firstDate: DateTime(1900),
                            lastDate: DateTime(2100),
                            useRootNavigator: true,
                            locale: Locale('vi','VN'),
                            );
                            if(rangeDate != null &&  rangeDate != _selectedDate){
                            setState(() {
                               _selectedDate = rangeDate;
                               print(_selectedDate!.start.millisecondsSinceEpoch);
                            });
                            _controller.text = DateFormat('dd/MM/yyyy').format(rangeDate.start).toString()+ ' - ' +
                            DateFormat('dd/MM/yyyy').format(rangeDate.end).toString();
                            }},),
                      const SizedBox(width: 25),
                      ElevatedButton(
                        onPressed: (){
                          userBillCubit.fetchUserBill(
                              userId: _selectedId,
                              begin: _selectedDate!= null ? _selectedDate!.start.millisecondsSinceEpoch ~/1000: null,
                              end: _selectedDate!= null ? _selectedDate!.end.millisecondsSinceEpoch~/1000: null,
                          );
                        },
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
                BlocBuilder<UserBillCubit, UserBillState>(
                  bloc: Modular.get<UserBillCubit>(),
                  builder: (context, state) {
                    if(state is UserBillLoaded){
                      data = state.response.userBills;
                      return JDataTable(
                        label: 'Tổng số phiếu đã nhập liệu: ',
                        value: data.fold(0, (previousValue, element) => previousValue! + element.done),
                        labelStyle: kBlackBigText,
                        valueStyle: kRedBigText,
                        maxHeight: size.height*.6, headerData: _header, body:
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
                              Container( width: size.width /7, child: Text(data[index].userName, style: kBlackSmallText,)),
                              Container( width: size.width /7, child: Text(data[index].time, style: kBlackSmallText,)),
                              Container( width: size.width /7, child: Text(data[index].done.toString(), style: kBlackSmallText,)),
                              Container( width: size.width /7, child: Text(data[index].imageError.toString(), style: kBlackSmallText,)),
                              Container( width: size.width /7, child: Text(data[index].error.toString(), style: kBlackSmallText,)),
                              Container( width: size.width/15, child: Center(child:
                              HoverButton(
                                onPressed: (){
                                  Modular.to.pushNamed('/statistic/${data[index].userId}');
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
                      );
                    }
                    return JDataTable(
                      label: 'Tổng số phiếu đã nhập liệu: ',
                      value: 0,
                      labelStyle: kBlackBigText,
                      valueStyle: kRedBigText,
                      maxHeight: size.height*.6, headerData: _header, body:
                        Center(
                          child: Container(
                              width: 60,
                              height: 60,
                              child: CircularProgressIndicator()),
                        )
                    );
                  },
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
