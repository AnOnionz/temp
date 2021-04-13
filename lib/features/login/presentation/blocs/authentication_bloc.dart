import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sp_bill/core/common/keys.dart';
import 'package:sp_bill/features/login/data/model/login_model.dart';
import 'package:sp_bill/features/login/domain/entities/login_entity.dart';


part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({required this.preferences}) : super(AuthenticationInitial());

  final SharedPreferences preferences;
  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AppStarted) {
      try {
          String? user = preferences.getString(USER);
          if (user != null) {
          print('User:' + user);
          Future.delayed(Duration.zero);
          yield AuthenticationAuthenticated(user: LoginModel.fromJson(jsonDecode(user)));
        } else {
          yield AuthenticationUnauthenticated();
        }
      } catch (e, s) {
        print(e);
        print(s);
        yield AuthenticationUnauthenticated();
      }
    }

    if (event is LoggedIn) {
      yield AuthenticationLoading();
      preferences.setString(USER, jsonEncode(event.loginEntity.toJson()));
      Future.delayed(Duration.zero);
      yield AuthenticationAuthenticated(user: event.loginEntity);
    }

    if (event is LoggedOut) {
      preferences.remove(USER);
      yield AuthenticationUnauthenticated();
    }
  }
 Future<LoginEntity> getUser() async{
   final jsonString = preferences.getString(USER);
   return LoginModel.fromJson(jsonDecode(jsonString!));
 }


}
