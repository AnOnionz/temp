part of 'userbill_cubit.dart';

@immutable
abstract class UserBillState {}

class UserBillInitial extends UserBillState {}
class UserBillLoaded extends UserBillState {
  final UserBillResponse response;

  UserBillLoaded({@required this.response});
}
class UserBillLoadFail extends UserBillState{}