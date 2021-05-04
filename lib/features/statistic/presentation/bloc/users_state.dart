part of 'users_cubit.dart';

abstract class FetchUsersState extends Equatable {
  const FetchUsersState();
}

class FetchUsersInitial extends FetchUsersState {
  @override
  List<Object> get props => [];
}
class FetchUsersLoaded extends FetchUsersState {
  final List<UserEntity> users;

  FetchUsersLoaded({@required this.users});
  @override
  List<Object> get props => [users];
}
class FetchUsersFailure extends FetchUsersState {

  FetchUsersFailure();
  @override
  List<Object> get props => [];
}
