import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sp_bill/core/usecases/usecase.dart';
import 'package:sp_bill/features/statistic/data/model/user_model.dart';
import 'package:sp_bill/features/statistic/domain/entities/user.dart';
import 'package:sp_bill/features/statistic/domain/usecases/fetch_all_user_usecase.dart';

part 'users_state.dart';

class UsersCubit extends Cubit<FetchUsersState> {
  final FetchAllUserUseCase fetchAllUser;
  UsersCubit({required this.fetchAllUser}) : super(FetchUsersInitial());

  void fetchUsers() async {
    final users = await fetchAllUser(NoParams());
    emit(users.fold((l) => FetchUsersLoaded(users: []), (r) => FetchUsersLoaded(users: r..insert(0, UserModel(id: 0, userName: 'Tất cả')))));

  }
}
