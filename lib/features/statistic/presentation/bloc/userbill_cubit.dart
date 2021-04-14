import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sp_bill/features/statistic/domain/entities/user_bill_response.dart';
import 'package:sp_bill/features/statistic/domain/usecases/fetch_all_user_bill_usecase.dart';

part 'userbill_state.dart';

class UserBillCubit extends Cubit<UserBillState> {
  final FetchAllUserBillUseCase fetchAllUserBill;
  UserBillCubit({required this.fetchAllUserBill}) : super(UserBillInitial());

  void fetchUserBill({int? begin,int? end, int? userId}) async {
    final userBills = await fetchAllUserBill(UserBillParam(begin: begin, end: end, userId: userId));
    emit(userBills.fold((l) => UserBillLoadFail(), (r) => UserBillLoaded(response: r)));
  }
}
