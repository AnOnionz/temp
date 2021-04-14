import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:sp_bill/features/statistic/domain/entities/bill_response.dart';
import 'package:sp_bill/features/statistic/domain/usecases/fetch_all_bill_usecase.dart';

part 'bill_state.dart';

class BillCubit extends Cubit<BillState> {
  static BillParams filter = BillParams(userId: 0);
  final FetchAllBillUseCase fetchAllBill;
  BillCubit({required this.fetchAllBill}) : super(BillInitial());

  void fetchBill({int? begin, int? end, int? status, int? billId, String? outletCode, required int userId}) async {
    final bills = await fetchAllBill(BillParams(userId: userId, begin: begin, end: end, outletCode: outletCode, billId: billId, status: status));
    filter = BillParams(userId: userId, begin: begin, end: end, outletCode: outletCode, billId: billId, status: status);
    emit(bills.fold((l) => BillLoadFailure(), (r) => BillLoaded(response: r)));
  }
  void fetchIndexPage({required int page}) async {
    emit(BillLoadLoading());
    final bills = await fetchAllBill(BillParams(page: page, userId: filter.userId, billId: filter.billId, outletCode: filter.outletCode, begin: filter.begin, end: filter.end, status: filter.status));
    emit(bills.fold((l) => BillLoadFailure(), (r) => BillLoaded(response: r)));
  }
}
