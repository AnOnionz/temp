import 'package:dartz/dartz.dart';
import 'package:sp_bill/core/error/Exception.dart';
import 'package:sp_bill/core/error/failure.dart';
import 'package:sp_bill/features/login/presentation/blocs/authentication_bloc.dart';
import 'package:sp_bill/features/statistic/data/datasources/statistic_remote_datasource.dart';
import 'package:sp_bill/features/statistic/domain/entities/bill_detail.dart';
import 'package:sp_bill/features/statistic/domain/entities/bill_response.dart';
import 'package:sp_bill/features/statistic/domain/entities/excel.dart';
import 'package:sp_bill/features/statistic/domain/entities/user.dart';
import 'package:sp_bill/features/statistic/domain/entities/user_bill_response.dart';
import 'package:sp_bill/features/statistic/domain/repositories/statistic_repository.dart';
import 'package:flutter/foundation.dart';

class StatisticRepositoryImpl implements StatisticRepository{
  final StatisticRemoteDataSource remoteDataSource;
  final AuthenticationBloc authenticationBloc;

  StatisticRepositoryImpl({@required this.remoteDataSource,@required this.authenticationBloc});

  @override
  Future<Either<Failure, List<UserEntity>>> fetchAllUser() async {
    try {
      final users = await remoteDataSource.fetchAllUser();
      return Right(users);
    } on InternetException catch(_){
      return Left(InternetFailure());
    } on UnAuthenticateException catch (_) {
      authenticationBloc.add(LoggedOut());
      return Left(UnAuthenticateFailure());
    } on ResponseException catch (error) {
      return Left(ResponseFailure(message: error.message));
    } on InternalException catch (_) {
      return Left(InternalFailure());
    }
  }

  @override
  Future<Either<Failure, UserBillResponse>> fetchAllUserBill({int begin,int end, int userId}) async {
    try {
      final userBills = await remoteDataSource.fetchAllUserBill(begin: begin, end: end, userId: userId);
      return Right(userBills);
    } on InternetException catch(_){
      return Left(InternetFailure());
    } on UnAuthenticateException catch (_) {
      authenticationBloc.add(LoggedOut());
      return Left(UnAuthenticateFailure());
    } on ResponseException catch (error) {
      return Left(ResponseFailure(message: error.message));
    } on InternalException catch (_) {
      return Left(InternalFailure());
    }
  }

  @override
  Future<Either<Failure, BillResponse>> fetchAllBill({int begin, int end, int status, int billId, String outletCode, @required int userId, int page}) async{
    try {
      final bills = await remoteDataSource.fetchAllBill(userId: userId, begin: begin, end: end, billId: billId, status: status, outletCode: outletCode, page: page);
      return Right(bills);
    } on InternetException catch(_){
      return Left(InternetFailure());
    } on UnAuthenticateException catch (_) {
      authenticationBloc.add(LoggedOut());
      return Left(UnAuthenticateFailure());
    } on ResponseException catch (error) {
      return Left(ResponseFailure(message: error.message));
    } on InternalException catch (_) {
      return Left(InternalFailure());
    }
  }

  @override
  Future<Either<Failure, BillDetailEntity>> fetchBillDetail({@required String token}) async{
    try {
      final detail = await remoteDataSource.fetchBillDetail(token: token);
      return Right(detail);
    } on InternetException catch(_){
      return Left(InternetFailure());
    } on UnAuthenticateException catch (_) {
      authenticationBloc.add(LoggedOut());
      return Left(UnAuthenticateFailure());
    } on ResponseException catch (error) {
      return Left(ResponseFailure(message: error.message));
    } on InternalException catch (_) {
      return Left(InternalFailure());
    }
  }

  @override
  Future<Either<Failure, List<String>>> fetchAllPath({int begin, int end, int status, int billId, String outletCode, @required int userId}) async {
    try {
      final parts = await remoteDataSource.fetchAllPart(outletCode: outletCode, status: status, end: end, begin: begin, billId: billId, userId: userId);
      return Right(parts);
    } on InternetException catch(_){
      return Left(InternetFailure());
    } on UnAuthenticateException catch (_) {
      authenticationBloc.add(LoggedOut());
      return Left(UnAuthenticateFailure());
    } on ResponseException catch (error) {
      return Left(ResponseFailure(message: error.message));
    } on InternalException catch (_) {
      return Left(InternalFailure());
    }
  }

  @override
  Future<Either<Failure, List<Map<String, dynamic>>>> fetchAllReport({List<String> allPath}) async {
    try {
      final report = await remoteDataSource.fetchAllReport(allPath: allPath);
      return Right(report);
    } on InternetException catch(_){
      return Left(InternetFailure());
    } on UnAuthenticateException catch (_) {
      authenticationBloc.add(LoggedOut());
      return Left(UnAuthenticateFailure());
    } on ResponseException catch (error) {
      return Left(ResponseFailure(message: error.message));
    } on InternalException catch (_) {
      return Left(InternalFailure());
    }
  }


}