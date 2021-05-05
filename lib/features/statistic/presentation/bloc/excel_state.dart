part of 'excel_cubit.dart';

@immutable
abstract class ExcelState {}

class ExcelInitial extends ExcelState {}
class ExcelLoadedPart extends ExcelState {
  final List<String> allPath;

  ExcelLoadedPart({this.allPath});
}
class ExcelFetchSuccess extends ExcelState {
  final List<Map<String, dynamic>> data;

  ExcelFetchSuccess({this.data});
}
class ExcelFailure extends ExcelState {}
class ExcelLoading extends ExcelState {}