import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sp_bill/core/usecases/usecase.dart';
import 'package:sp_bill/core/utils/dialogs.dart';
import 'package:sp_bill/features/statistic/domain/entities/excel.dart';
import 'package:sp_bill/features/statistic/domain/usecases/fetch_all_bill_usecase.dart';
import 'package:sp_bill/features/statistic/domain/usecases/fetch_all_part_usecase.dart';
import 'package:sp_bill/features/statistic/domain/usecases/fetch_all_report_usecase.dart';
import 'package:sp_bill/features/statistic/presentation/bloc/bill_cubit.dart';

part 'excel_state.dart';

class ExcelCubit extends Cubit<ExcelState> {
  final FetchAllPartUseCase fetchAllPart;
  final FetchAllReportUseCase fetchAllReport;
  ExcelCubit({@required this.fetchAllPart, @required this.fetchAllReport}) : super(ExcelInitial());

  void loadPart({BillParams f}) async {
    final filter = f ?? BillCubit.filter;
    print(filter.userId);
    emit(ExcelLoading());
      final part = await fetchAllPart(FetchPathParams(billId: filter.billId, outletCode: filter.outletCode, begin: filter.begin, end: filter.end, status: filter.status));
      emit(part.fold(
              (l) {
        displayError(l);
        return ExcelFailure();},
              (r) => ExcelLoadedPart(allPath: r)));
  }
  void loadData({@required List<String> allPath}) async {
    emit(ExcelLoading());
    final totalIndex = allPath.map((e) => int.parse(e.split('=').elementAt(1))).toList();
    print(totalIndex);
    final data = await fetchAllReport(ReportParams(allPath: allPath));
    emit(data.fold((l) {
      displayError(l);
      return ExcelFailure();},
      (r) => ExcelFetchSuccess(data: r)));
  }
}


