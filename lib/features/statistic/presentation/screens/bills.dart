import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:sp_bill/core/utils/string_tranform.dart';
import 'package:sp_bill/core/widgets/date_time_field.dart';
import 'package:sp_bill/core/widgets/dropdown_field.dart';
import 'package:sp_bill/core/widgets/hover_button.dart';
import 'package:sp_bill/core/widgets/pagination.dart';
import 'package:sp_bill/core/widgets/single_filed.dart';
import 'package:sp_bill/features/login/presentation/blocs/authentication_bloc.dart';
import 'package:sp_bill/features/statistic/domain/entities/bill.dart';
import 'package:sp_bill/features/statistic/domain/entities/user.dart';
import 'package:sp_bill/features/statistic/presentation/bloc/bill_cubit.dart';
import 'package:sp_bill/features/statistic/presentation/bloc/users_cubit.dart';
import 'package:sp_bill/features/statistic/presentation/widgets/status_bill.dart';
import 'package:sp_bill/features/statistic/presentation/widgets/total_excel_button.dart';
import '../../../../core/common/constants.dart';
import '../../../../core/widgets/data_table.dart';
import '../../../../core/widgets/nav.dart';
import '../../../../core/widgets/tab_title.dart';
import '../../../../responsive.dart';

class Bills extends StatefulWidget {
  final String id;
  final String time;

  Bills({Key key, @required this.id, this.time}) : super(key: key);

  @override
  _BillsState createState() => _BillsState();
}

class _BillsState extends State<Bills> {
  ScrollController _scrollController = ScrollController();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _billIDController = TextEditingController();
  TextEditingController _outletCodeController = TextEditingController();
  DateTimeRange _selectedDate;
  String _selectedStatus;
  final BillCubit billCubit = Modular.get<BillCubit>();

  List<Map<String, dynamic>> exData = [];
  List<BillEntity> data = [];
  int currentIndex = 1;
  String _selectedUser ;
  int _selectedId ;
  int totalPage = 1;

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
    _selectedId = int.parse(widget.id);
    _selectedUser = UsersCubit.allUser.firstWhere((element) => element.id.toString() == widget.id).userName;
    _dateController.text = widget.time != ''
        ? '${widget.time.split('_').join('/')} - ${widget.time.split('_').join('/')}'
        : '';
    _selectedDate = DateTimeRange(
        start: DateFormat("dd-MM-yyyy").parse(widget.time.split('_').join('-')),
        end: DateFormat("dd-MM-yyyy").parse(widget.time.split('_').join('-')));
    billCubit.fetchBill(
        userId: int.parse(widget.id),
        begin: DateFormat("dd-MM-yyyy")
                .parse(widget.time.split('_').join('-'))
                .millisecondsSinceEpoch ~/
            1000,
        end: DateFormat("dd-MM-yyyy")
                .parse(widget.time.split('_').join('-'))
                .millisecondsSinceEpoch ~/
            1000);
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
            userName: (Modular.get<AuthenticationBloc>().state
                    as AuthenticationAuthenticated)
                .user
                .userName,
            index: 5,
          ),
          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 38.0, right: 38.0, left: 38.0),
              child: Stack(
                children: [
                  TotalExcelButton(
                    user: _selectedUser,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TabTitle(text: 'danh sách phiếu mua'.toUpperCase()),
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: FractionallySizedBox(
                          widthFactor: 6 / 8 + .03,
                          child: Wrap(
                            crossAxisAlignment: WrapCrossAlignment.end,
                            children: [
                              SingleField(
                                label: 'ID phiếu',
                                width: size.width / 8,
                                controller: _billIDController,
                                inputFormatter: <TextInputFormatter>[
                                  LengthLimitingTextInputFormatter(15),
                                  FilteringTextInputFormatter.digitsOnly,
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9]'))
                                ],
                              ),
                              SingleField(
                                label: 'Outlet code',
                                width: size.width / 8,
                                controller: _outletCodeController,
                                inputFormatter: <TextInputFormatter>[
                                  LengthLimitingTextInputFormatter(15),
                                  FilteringTextInputFormatter.digitsOnly,
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9]'))
                                ],
                              ),
                              DropdownField(
                                label: 'User',
                                width: 230,
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    value: _selectedUser,
                                    underline: Container(
                                      color: Colors.black,
                                      height: 3,
                                    ),
                                    icon: Icon(Icons.keyboard_arrow_down),
                                    isDense: true,
                                    onChanged: (String newValue) {
                                      setState(() {
                                        if (newValue != null) {
                                          _selectedUser = newValue;
                                        }
                                      });
                                    },
                                    items: UsersCubit.allUser
                                        .map((UserEntity user) {
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
                                    _dateController.text =
                                        DateFormat('dd/MM/yyyy')
                                                .format(rangeDate.start)
                                                .toString() +
                                            ' - ' +
                                            DateFormat('dd/MM/yyyy')
                                                .format(rangeDate.end)
                                                .toString();
                                  }
                                },
                              ),
                              DropdownField(
                                label: 'Tình trạng',
                                width: 230,
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    icon: InkWell(
                                        onTap: () {
                                          setState(() {
                                            _selectedStatus = null;
                                          });
                                        },
                                        child: _selectedStatus != null
                                            ? Icon(
                                                Icons.close,
                                                size: 20,
                                              )
                                            : Icon(Icons.keyboard_arrow_down)),
                                    isDense: true,
                                    value: _selectedStatus,
                                    onChanged: (String newValue) {
                                      setState(() {
                                        if (newValue != null) {
                                          _selectedStatus = newValue;
                                        }
                                      });
                                    },
                                    items: status.entries
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
                                  setState(() {
                                    currentIndex = 1;
                                  });
                                  billCubit.fetchBill(
                                    userId: _selectedId,
                                    outletCode:
                                        _outletCodeController.text.isEmpty
                                            ? null
                                            : _outletCodeController.text,
                                    billId: _billIDController.text.isEmpty
                                        ? null
                                        : int.parse(_billIDController.text),
                                    begin: _selectedDate != null
                                        ? _selectedDate
                                                .start.millisecondsSinceEpoch ~/
                                            1000
                                        : null,
                                    end: _selectedDate != null
                                        ? _selectedDate
                                                .end.millisecondsSinceEpoch ~/
                                            1000
                                        : null,
                                    status: _selectedStatus != null
                                        ? int.parse(_selectedStatus)
                                        : null,
                                  );
                                },
                                child: Text(
                                  'Tìm',
                                  style: kWhiteSmallText,
                                ),
                                style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 40,
                                        vertical: 16) // foreground
                                    ),
                              )
                            ],
                          ),
                        ),
                      ),
                      BlocBuilder<BillCubit, BillState>(
                        bloc: billCubit,
                        builder: (context, state) {
                          if (state is BillLoaded) {
                            print(state.response.currentPage);
                            data = state.response.bills;
                            return Column(
                              children: [
                                JDataTable(
                                  // label: 'Kết quả: ',
                                  // value: state.response.,
                                  // labelStyle: kRedText,
                                  // valueStyle: kRedText,
                                  maxHeight: size.height - 415,
                                  headerData: _header,
                                  body: data.isNotEmpty
                                      ? ListView.separated(
                                          controller: _scrollController,
                                          separatorBuilder: (context, index) =>
                                              Divider(
                                            color: kGreyColor,
                                          ),
                                          itemBuilder: (context, index) =>
                                              Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 7.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                    width: size.width / 25,
                                                    child: Text(
                                                        '${index + 1 + (state.response.currentPage == 0 ? state.response.currentPage : state.response.currentPage - 1) * 20}')),
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
                                                      displayPrice(data[index]
                                                          .totalBill),
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
                                                        status: data[index]
                                                            .status)),
                                                Container(
                                                    width: size.width / 25,
                                                    child: Center(
                                                      child: HoverButton(
                                                        onPressed: () {
                                                          Modular.to.pushNamed(
                                                              '/bill/${data[index].token}');
                                                        },
                                                        icon: Icon(
                                                          Icons
                                                              .remove_red_eye_sharp,
                                                          color: Colors.black54,
                                                        ),
                                                        onActive: Icon(
                                                          Icons
                                                              .remove_red_eye_sharp,
                                                          color: kGreenColor,
                                                        ),
                                                      ),
                                                    )),
                                              ],
                                            ),
                                          ),
                                          itemCount: data.length,
                                          shrinkWrap: true,
                                        )
                                      : Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 30),
                                          child: Center(
                                              child: Text(
                                            'Danh sách trống',
                                            style: kGreySmallText,
                                          )),
                                        ),
                                ),
                                const SizedBox(
                                  height: 6,
                                ),
                                Pagination(
                                  current: state.response.currentPage == 0
                                      ? 1
                                      : state.response.currentPage,
                                  total: state.response.totalPage,
                                  callback: (index) {
                                    billCubit.fetchIndexPage(page: index);
                                    // setState(() {
                                    //   currentIndex = index;
                                    //   _scrollController.animateTo(
                                    //     _scrollController.position.minScrollExtent,
                                    //     curve: Curves.easeOut,
                                    //     duration: const Duration(milliseconds: 100),
                                    //   );
                                    // });
                                  },
                                )
                              ],
                            );
                          }
                          if (state is BillLoadFailure) {
                            return JDataTable(
                                // label: 'Kết quả: ',
                                // value: 0,
                                // labelStyle: kRedText,
                                // valueStyle: kRedText,
                                maxHeight: size.height * 0.6,
                                headerData: _header,
                                body: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 30),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Danh sách trống',
                                        style: kGreySmallText,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      ElevatedButton(
                                          onPressed: () {
                                            billCubit.reloadBill();
                                          },
                                          child: Text('tải lại')),
                                    ],
                                  ),
                                ));
                          }
                          return JDataTable(
                              // label: 'Kết quả: ',
                              // value: 0,
                              // labelStyle: kRedText,
                              // valueStyle: kRedText,
                              maxHeight: size.height * 0.6,
                              headerData: _header,
                              body: Center(
                                child: Container(
                                  height: 60,
                                  width: 60,
                                  child: CircularProgressIndicator(),
                                ),
                              ));
                        },
                      )
                    ],
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
