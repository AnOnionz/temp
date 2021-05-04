import 'package:sp_bill/features/statistic/domain/entities/user_bill.dart';
import 'package:flutter/foundation.dart';

class UserBillResponse {
  final List<UserBillEntity> userBills;

  UserBillResponse({@required this.userBills});
}