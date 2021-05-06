import 'package:bloc/bloc.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:sp_bill/core/utils/dialogs.dart';
import 'package:sp_bill/features/statistic/domain/usecases/fetch_all_bill_usecase.dart';
import 'package:sp_bill/features/statistic/domain/usecases/fetch_all_part_usecase.dart';
import 'package:sp_bill/features/statistic/domain/usecases/fetch_all_report_usecase.dart';
import 'package:sp_bill/features/statistic/presentation/bloc/bill_cubit.dart';

import '../../../../responsive.dart';

part 'excel_state.dart';

class ExcelCubit extends Cubit<ExcelState> {
  final FetchAllPartUseCase fetchAllPart;
  final FetchAllReportUseCase fetchAllReport;
  ExcelCubit({@required this.fetchAllPart, @required this.fetchAllReport}) : super(ExcelInitial());

  void loadPart({BillParams f, String user}) async {
    final filter = f ?? BillCubit.filter;
    emit(ExcelLoading());
      final part = await fetchAllPart(FetchPathParams(billId: filter.billId, outletCode: filter.outletCode, begin: filter.begin, end: filter.end, status: filter.status, userId: filter.userId));
      emit(part.fold(
              (l) {
        displayError(l);
        return ExcelFailure();},
              (r) {
                loadData(allPath: r, user: user);
             return ExcelLoadedPart(allPath: r); }));
  }
  void loadData({@required List<String> allPath, String user}) async {
    emit(ExcelLoading());
    final data = await fetchAllReport(ReportParams(allPath: allPath));
    emit(data.fold((l) {
      displayError(l);
      return ExcelFailure();},
      (r) {
      exportExcel(data: r, name: user + '-at-' + DateFormat('dd/MM').format(DateTime.fromMillisecondsSinceEpoch(BillCubit.filter.begin*1000)).split('_').join('/') + '-' + DateFormat('dd/MM').format(DateTime.fromMillisecondsSinceEpoch(BillCubit.filter.end*1000)).split('_').join('/'));
      return ExcelFetchSuccess(data: r);}));
  }
}



