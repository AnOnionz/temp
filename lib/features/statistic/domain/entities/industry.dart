import 'package:equatable/equatable.dart';

class IndustryEntity extends Equatable{
  final int industryId;
  final String industryName;
  final String productName;
  final int qty;
  final String unit;
  final int unitPrince;

  IndustryEntity({this.industryId, this.industryName, this.productName, this.qty, this.unit, this.unitPrince});
  @override
  List<Object> get props => [industryId];

}