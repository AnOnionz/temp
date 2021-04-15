import 'package:dio/dio.dart';
import 'package:sp_bill/core/error/Exception.dart';
export 'package:dio/dio.dart';
// custom dio
class CDio {

  //static String apiBaseUrl;
   static const String apiBaseUrl = 'https://input.sp21.imark.vn';

  static const String apiPath = 'api';
  late Dio client;

  CDio(){
    client = Dio(BaseOptions(
      baseUrl: '$apiBaseUrl/$apiPath/',
      connectTimeout: 18000,
      receiveTimeout: 60000,
      responseType: ResponseType.json,
      validateStatus: (status) => true,
      receiveDataWhenStatusError: true,
    ),);
  }

  Future<Response> getResponse({required String path, Map<String, dynamic>? data}) async {
    try {
      print('GET ${client.options.baseUrl}$path');
      final response = await client.get(path, queryParameters: data);
        print('GET $path: ${response.data}');
        if (response.statusCode == 200) {
          return response;
        }
        if (response.statusCode == 401) {
          throw(UnAuthenticateException());
        }
        if (response.statusCode == 500) {
          throw(InternalException());
        }
        if ( response.statusCode == 400 || response.data == {}) {
          throw(ResponseException(message:'Error: 400' ));
        }
          throw(ResponseException(
              message: "Đã có lỗi xảy ra (${response.statusCode}) "));
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout ||
          e.type == DioErrorType.receiveTimeout) {
        throw(InternetException());
      }
      throw(ResponseException(message: "Đã xảy ra lỗi ngoài ý muốn, vui lòng chờ trong giây lát"));
    }
  }
  Future<Response> postResponse({required String path, dynamic? data}) async{
      try {
        print('POST ${client.options.baseUrl}$path');
        final response = await client.post(path, data: data);
        print('POST $path: ${response.data}');
        if (response.statusCode == 200 ) {
          return response;
        }
        if (response.statusCode == 401) {
          throw(UnAuthenticateException());
        }
          if (response.statusCode == 500) {
            throw(InternalException());
        }
        if ( response.statusCode == 400 || response.data == {}) {
          throw(ResponseException(message:'Error: 400' ));
        }
        throw(ResponseException(message: "Đã có lỗi xảy ra (Code: ${response.statusCode})"));

      } on DioError catch (e) {
        if (e.type == DioErrorType.connectTimeout ||
            e.type == DioErrorType.receiveTimeout ) {
          throw(InternetException());
        }
        throw(ResponseException(message: "Đã xảy ra lỗi ngoài ý muốn, vui lòng chờ trong giây lát"));
      }

  }

  void setBearerAuth(String token) {
   client.options.headers.addAll({'Authorization': ' Bearer $token'});
  }

  void addInterceptor(Interceptor interceptor) {
    client.interceptors.add(interceptor);
  }

  void setValidateStatus(ValidateStatus validateStatus) {
    client.options.validateStatus = validateStatus;
  }
  void setHeader(int version){
    client.options.headers.addAll({
      'VersionCodeSp': '$version'});
  }

}
