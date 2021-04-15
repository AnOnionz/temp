import 'package:asuka/asuka.dart' as asuka;
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sp_bill/core/common/constants.dart';
import 'package:sp_bill/core/error/failure.dart';
import 'package:sp_bill/features/login/presentation/blocs/authentication_bloc.dart';
import 'package:sp_bill/features/login/presentation/blocs/login_bloc.dart';

void displayError(Failure failure){
  if(failure is ResponseFailure){
    asuka.showDialog(
      barrierDismissible: true,
      builder: (context) {
      return AlertDialog(
        title: Text('Thông báo'),
        content: Text(failure.message),
        actions: [
          TextButton(onPressed: (){
            Navigator.pop(context);
          }, child: Text('Đóng', style: TextStyle(color: kRedColor, fontSize: 15),)),
        ],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0)
        ),
        buttonPadding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10),
      );
    },);
  }
  if(failure is UnAuthenticateFailure) {
    asuka.showDialog(
      barrierDismissible: false,
      builder: (context) {
        Future.delayed(Duration(milliseconds: 1500), (){
          Navigator.pop(context);
          Modular.get<LoginBloc>().add(LogoutButtonPress());
        });
        return AlertDialog(
          title: Text('Thông báo'),
          content: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(failure.message),
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0)
          ),
        );

      },);


  }
  if(failure is InternalFailure){
    asuka.showDialog(
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          title: Text('Thông báo'),
          content: Text(failure.message),
          actions: [
            TextButton(onPressed: (){
              Navigator.pop(context);
            }, child: Text('Đóng', style: TextStyle(color: kRedColor, fontSize: 15),)),
          ],
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0)
          ),
          buttonPadding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10),
        );
      },);
  }
  if(failure is InternetFailure){
    asuka.showDialog(
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          title: Text('Thông báo'),
          content: Text(failure.message),
          actions: [
            TextButton(onPressed: (){
              Navigator.pop(context);
            }, child: Text('Đóng', style: TextStyle(color: kRedColor, fontSize: 15),)),
          ],
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0)
          ),
          buttonPadding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10),
        );
      },);
  }
}
