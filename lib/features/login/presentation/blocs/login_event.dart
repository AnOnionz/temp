part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {
  const LoginEvent();
}

class LoginButtonPress extends LoginEvent{
  final String username;
  final String password;

  const LoginButtonPress({required this.username, required this.password});

}
class LogoutButtonPress extends LoginEvent{

}
