part of 'bill_cubit.dart';

@immutable
abstract class BillState extends Equatable {
}

class BillInitial extends BillState {
  @override
  List<Object?> get props => [];
}
class BillLoaded extends BillState {
  final BillResponse response;

  BillLoaded({required this.response});

  @override
  List<Object?> get props => [response];
}
class BillLoadLoading extends BillState{
  @override
  List<Object?> get props => [];
}
class BillLoadFailure extends BillState{
  @override
  List<Object?> get props => [];
}