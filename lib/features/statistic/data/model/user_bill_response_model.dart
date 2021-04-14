import 'package:sp_bill/features/statistic/data/model/user_bill_model.dart';
import 'package:sp_bill/features/statistic/domain/entities/user_bill.dart';
import 'package:sp_bill/features/statistic/domain/entities/user_bill_response.dart';

class UserBillResponseModel extends UserBillResponse{
  UserBillResponseModel({
      required List<UserBillEntity> userBills, }
      ) : super(userBills: userBills,);

  factory UserBillResponseModel.fromJson(List<dynamic> json) {
    return UserBillResponseModel(
        userBills: json.map((e) => UserBillModel.fromJson(e)).toList(),
    );
  }

}