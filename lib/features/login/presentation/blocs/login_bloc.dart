import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:sp_bill/core/common/keys.dart';
import 'package:sp_bill/core/error/failure.dart';
import 'package:sp_bill/features/login/domain/entities/login_entity.dart';
import 'package:sp_bill/features/login/domain/usecases/usecase_login.dart';
import 'package:sp_bill/features/login/domain/usecases/usecase_logout.dart';


import 'authentication_bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase login;
  final LogoutUseCase logout;
  final AuthenticationBloc authenticationBloc;
  LoginBloc({
    required this.login,
    required this.logout,
    required this.authenticationBloc,
  })  : super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginButtonPress) {
      yield LoginLoading();
      final loginUseCase = await login(LoginParams(
          username: event.username,
          password: event.password));
      yield* _eitherLoginOrErrorState(loginUseCase,);
    }
    if (event is LogoutButtonPress) {
      authenticationBloc.localStorage.deleteItem(USER);
      authenticationBloc.add(LoggedOut());
    }
  }
}

Stream<LoginState> _eitherLoginOrErrorState(
  Either<Failure, LoginEntity> either,
) async* {
  yield either.fold((failure) {
    if (failure is InternalFailure) {
     return LoginInternalServer(message: failure.message);
    }
    return LoginFailure(message: failure.message);
  },
      (user) {
        return LoginSuccess(user: user);
  });
}


