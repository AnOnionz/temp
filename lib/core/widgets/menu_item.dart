import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../core/common/constants.dart';


class MenuItem extends StatelessWidget {
  final String title;
  final String route;
  final bool isActive;

  MenuItem({Key? key, required this.title, required this.route, required this.isActive}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        // BlocProvider.of<NavCubit>(context).menuSelected(title);
        Modular.to.pushNamed('$route');
      },
      child: Container(
              width: 200,
              height: 63,
              decoration: BoxDecoration(
              color: isActive ? Colors.white12 : kGreenColor,
          ),
          child: Center(child: Text(title, style: kWhiteText,)),
      )
    );
  }
}
