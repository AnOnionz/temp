import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:sp_bill/core/utils/dialogs.dart';
import 'package:sp_bill/features/statistic/domain/entities/bill_response.dart';
import 'package:sp_bill/features/statistic/domain/usecases/fetch_all_bill_usecase.dart';
import 'package:sp_bill/features/statistic/presentation/bloc/excel_cubit.dart';

part 'bill_state.dart';

class BillCubit extends Cubit<BillState> {
  static BillParams filter = BillParams(userId: 0);
  final FetchAllBillUseCase fetchAllBill;
  BillCubit({@required this.fetchAllBill}) : super(BillInitial());

  void fetchBill({int begin, int end, int status, int billId, String outletCode, int userId}) async {
    final nBegin = begin != null ? begin + DateTime.now().hour*3600 : null;
    final nEnd = end !=null ? end +  DateTime.now().minute*60 : null;
    filter = BillParams(userId: userId, begin: nBegin, end: nEnd, outletCode: outletCode, billId: billId, status: status);
    final bills = await fetchAllBill(filter);
    emit(bills.fold((l) {
      displayError(l);
      return BillLoadFailure();}, (r) => BillLoaded(response: r)));
  }
  void fetchIndexPage({@required int page}) async {
    emit(BillLoadLoading());
    final bills = await fetchAllBill(BillParams(page: page, userId: filter.userId, billId: filter.billId, outletCode: filter.outletCode, begin: filter.begin, end: filter.end, status: filter.status));
    emit(bills.fold((l){
      displayError(l);
      return BillLoadFailure();}, (r) => BillLoaded(response: r)));
  }
  void reloadBill() async {
    emit(BillLoadLoading());
    final bills = await fetchAllBill(filter);
    emit(bills.fold((l){
      displayError(l);
      return BillLoadFailure();}, (r) => BillLoaded(response: r)));
  }
}
