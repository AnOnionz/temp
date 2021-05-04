import 'package:flutter/foundation.dart';
class UnAuthenticateException implements Exception{
  final String message ;

  UnAuthenticateException({this.message = 'exception'});

  @override
  String toString() {
    return message;
  }
}
class ResponseException implements Exception{
  final String message;

  ResponseException({@required this.message});

}
class PermissionException implements Exception{}
class InternetException implements Exception{}
class InternalException implements Exception{}

