part of 'bill_detail_cubit.dart';

@immutable
abstract class BillDetailState {}

class BillDetailInitial extends BillDetailState {}
class BillDetailLoaded extends BillDetailState {
  final BillDetailEntity detail;

  BillDetailLoaded({required this.detail});
}
class BillDetailFailure extends BillDetailState {}
