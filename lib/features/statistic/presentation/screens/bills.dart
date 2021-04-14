import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:sp_bill/core/widgets/date_time_field.dart';
import 'package:sp_bill/core/widgets/dropdown_field.dart';
import 'package:sp_bill/core/widgets/hover_button.dart';
import 'package:sp_bill/core/widgets/pagination.dart';
import 'package:sp_bill/core/widgets/single_filed.dart';
import 'package:sp_bill/features/statistic/domain/entities/bill.dart';
import 'package:sp_bill/features/statistic/presentation/bloc/bill_cubit.dart';
import 'package:sp_bill/features/statistic/presentation/bloc/users_cubit.dart';
import 'package:sp_bill/features/statistic/presentation/widgets/status_bill.dart';
import '../../../../core/common/constants.dart';
import '../../../../core/widgets/data_table.dart';
import '../../../../core/widgets/nav.dart';
import '../../../../core/widgets/tab_title.dart';
import '../../../../responsive.dart';

class Bills extends StatefulWidget {
  final String id;

  Bills({Key? key, required this.id}) : super(key: key);

  @override
  _BillsState createState() => _BillsState();
}

class _BillsState extends State<Bills> {
  ScrollController _scrollController = ScrollController();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _billIDController = TextEditingController();
  TextEditingController _outletCodeController = TextEditingController();
  DateTimeRange? _selectedDate;
  final BillCubit billCubit = Modular.get<BillCubit>();
  late List<BillEntity> data = [];
  String? _selectedStatus;

  final _header = {
    '#': 25,
    'ID phiếu': 10,
    'Outlet Code': 10,
    'Outlet Name': 7,
    'Tổng tiền': 10,
    'User nhập liệu': 10,
    'Thời gian nhập': 10,
    'Tình trạng': 10,
    '': 25,
  };
  final status = {
    '6': 'Hoàn thành',
    '5': 'Lỗi hình',
    '4': 'Thiếu thông tin',
  };

  @override
  void initState() {
    billCubit.fetchBill(userId: int.parse(widget.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

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
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 38.0, right: 38.0, left: 38.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TabTitle(text: 'danh sách phiếu mua'.toUpperCase()),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: FractionallySizedBox(
                      widthFactor: 6 / 8,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SingleField(
                            label: 'ID phiếu',
                            width: size.width / 8,
                            controller: _billIDController,
                          ),
                          SingleField(
                            label: 'Outlet code',
                            width: size.width / 8,
                            controller: _outletCodeController,
                          ),
                          DropdownField(
                            label: 'User nhập liệu',
                            width: size.width / 8,
                            disable: true,
                            child: BlocBuilder<UsersCubit, FetchUsersState>(
                              bloc: Modular.get<UsersCubit>()..fetchUsers(),
                              builder: (context, state) {
                                if (state is FetchUsersLoaded) {
                                  return DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      icon: Icon(Icons.keyboard_arrow_down),
                                      value: state.users.firstWhere((element) => element.id == int.parse(widget.id)).userName,
                                      style: kBlackSmallText,
                                      isDense: true,
                                      items: [
                                        DropdownMenuItem<String>(
                                          value: state.users.firstWhere((element) => element.id == int.parse(widget.id)).userName,
                                          child: Text(state.users.firstWhere((element) => element.id == int.parse(widget.id)).userName),
                                        )
                                      ],
                                    ),
                                  );
                                }
                                return DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    icon: Icon(Icons.keyboard_arrow_down),
                                    value: '',
                                    style: kBlackSmallText,
                                    isDense: true,
                                    items: [
                                      DropdownMenuItem<String>(
                                        value: '',
                                        child: Text(''),
                                      )
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                          DateTimeField(
                            label: 'Ngày nhập liệu',
                            width: size.width / 8,
                            controller: _dateController,
                            onTap: () async {
                              final rangeDate = await showDateRangePicker(
                                context: context,
                                firstDate: DateTime(1900),
                                lastDate: DateTime(2100),
                                useRootNavigator: true,
                                locale: Locale('vi', 'VN'),
                              );
                              if (rangeDate != null &&
                                  rangeDate != _selectedDate) {
                                setState(() {
                                  _selectedDate = rangeDate;
                                });
                                _dateController.text = DateFormat('dd/MM/yyyy')
                                        .format(rangeDate.start)
                                        .toString() +
                                    ' - ' +
                                    DateFormat('dd/MM/yyyy')
                                        .format(rangeDate.end)
                                        .toString();
                              }
                            },
                          ),
                        DropdownField(label: 'Tình trạng' ,width: 230, child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          icon: Icon(Icons.keyboard_arrow_down),
                          isDense: true,
                          value: _selectedStatus,
                          onChanged: (String? newValue) {
                            setState(() {
                              if(newValue!=null) {
                                _selectedStatus = newValue;
                              }
                            });
                          },
                          items:status.entries
                              .map((e) => DropdownMenuItem<String>(
                            value: e.key,
                            child: Text(e.value),
                            onTap: () {
                              setState(() {
                                _selectedStatus = e.key;
                              });
                            },
                          ))
                              .toList(),
                          ),
                         ),
                        ),
                          ElevatedButton(
                            onPressed: () {
                              billCubit.fetchBill(
                                userId: int.parse(widget.id),
                                outletCode: _outletCodeController.text.isEmpty? null :_outletCodeController.text ,
                                billId: _billIDController.text.isEmpty ? null :int.parse(_billIDController.text),
                                begin: _selectedDate != null ? _selectedDate!.start.millisecondsSinceEpoch ~/1000 : null,
                                end: _selectedDate != null ? _selectedDate!.end.millisecondsSinceEpoch ~/1000 : null,
                                status: _selectedStatus != null ? int.parse(_selectedStatus!) : null,
                              );
                            },
                            child: Text(
                              'Tìm',
                              style: kBlackSmallText,
                            ),
                            style: ElevatedButton.styleFrom(
                                primary: kGreyColor, // background
                                onPrimary: kGreenColor,
                                elevation: 0,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 40, vertical: 16) // foreground
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  BlocBuilder<BillCubit, BillState>(
                    bloc: billCubit,
                    builder: (context, state) {
                      if (state is BillLoaded) {
                        data = state.response.bills;
                        return JDataTable(
                          // label: 'Kết quả: ',
                          // value: state.response.,
                          // labelStyle: kRedText,
                          // valueStyle: kRedText,
                          maxHeight: size.height * 0.6,
                          headerData: _header,
                          body: ListView.separated(
                            controller: _scrollController,
                            separatorBuilder: (context, index) => Divider(
                              color: kGreyColor,
                            ),
                            itemBuilder: (context, index) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 7.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                      width: size.width / 25,
                                      child: Text('${index + 1}')),
                                  Container(
                                      width: size.width / 10,
                                      child: Text(
                                        data[index].id.toString(),
                                        style: kBlackSmallText,
                                      )),
                                  Container(
                                      width: size.width / 10,
                                      child: Text(
                                        data[index].outletCode,
                                        style: kBlackSmallText,
                                      )),
                                  Container(
                                      width: size.width / 7,
                                      child: Text(
                                        data[index].outletName,
                                        style: kBlackSmallText,
                                      )),
                                  Container(
                                      width: size.width / 10,
                                      child: Text(
                                        data[index].totalBill.toString(),
                                        style: kBlackSmallText,
                                      )),
                                  Container(
                                      width: size.width / 10,
                                      child: Text(
                                        data[index].userName,
                                        style: kBlackSmallText,
                                      )),
                                  Container(
                                      width: size.width / 10,
                                      child: Text(
                                        data[index].doneAt,
                                        style: kBlackSmallText,
                                      )),
                                  Container(
                                      width: size.width / 10,
                                      child: StatusBill(
                                          status: data[index].status)),
                                  Container(
                                      width: size.width / 25,
                                      child: Center(
                                        child: HoverButton(
                                          onPressed: () {
                                            Modular.to.pushNamed(
                                                '/statistic/${data[index].id}/edit');
                                          },
                                          icon: Image.asset(
                                            'assets/images/edit.png',
                                            height: 16,
                                            width: 16,
                                          ),
                                          onActive: Image.asset(
                                            'assets/images/edit_hover.png',
                                            height: 16,
                                            width: 16,
                                          ),
                                        ),
                                      )),
                                ],
                              ),
                            ),
                            itemCount: data.length,
                            shrinkWrap: true,
                          ),
                        );
                      }
                      return JDataTable(
                        // label: 'Kết quả: ',
                        // value: 0,
                        // labelStyle: kRedText,
                        // valueStyle: kRedText,
                        maxHeight: size.height * 0.6,
                        headerData: _header,
                        body: Center(child: Container(height: 60, width: 60, child: CircularProgressIndicator(),),)
                      );
                    },
                  ),
                  BlocBuilder<BillCubit, BillState>(
                    bloc: billCubit,
                    builder: (context, state) {
                      if(state is BillLoaded){
                        return Pagination(total: state.response.totalPage, callback: (index) {
                          billCubit.fetchIndexPage(page: index);
                          setState(() {
                            _scrollController.animateTo(
                              _scrollController.position.minScrollExtent,
                              curve: Curves.easeOut,
                              duration: const Duration(milliseconds: 100),
                            );
                          });
                        },);
                      }
                      return Container();
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
