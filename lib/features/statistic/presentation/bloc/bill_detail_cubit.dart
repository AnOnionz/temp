import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sp_bill/features/statistic/domain/entities/bill_detail.dart';
import 'package:sp_bill/features/statistic/domain/usecases/fetch_bill_detail_usecase.dart';

part 'bill_detail_state.dart';

class BillDetailCubit extends Cubit<BillDetailState> {
  final FetchBillDetailUseCase fetchBillDetail;
  BillDetailCubit(
  {required this.fetchBillDetail}
      ) : super(BillDetailInitial());

  void fetchDetail({required String token}) async {
    final detail = await fetchBillDetail(BillDetailParams(token: token));
    emit(detail.fold((l) => BillDetailFailure(), (r) => BillDetailLoaded(detail: r)));
  }
}
