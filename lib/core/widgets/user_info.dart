import 'package:flutter/material.dart';
import '../common/constants.dart';

class UserInfo extends StatelessWidget {
  final String name;

  const UserInfo({Key? key, required this.name}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text('Hi, $name ', style: kWhiteText,);
  }
}
