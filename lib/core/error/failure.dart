import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
// ignore: must_be_immutable
abstract class Failure extends Equatable{
    String message ;
    Failure(mess) : message = mess;

    @override
  String toString() {
    return '$message';
  }
    @override
  List<Object> get props => [message];
}
// ignore: must_be_immutable
class InternalFailure extends Failure{
  InternalFailure(): super("Đã xảy ra lỗi ngoài ý muốn");

}
// ignore: must_be_immutable
class UnAuthenticateFailure extends Failure{
  UnAuthenticateFailure(): super("Phiên đăng nhập đã hết hạn");

}
// ignore: must_be_immutable
class ResponseFailure extends Failure{
  ResponseFailure({message}): super(message);
}
// ignore: must_be_immutable
class InternetFailure extends Failure{
  InternetFailure() : super("Kết nối mạng không ổn định, vui lòng kiểm tra lại");
}



