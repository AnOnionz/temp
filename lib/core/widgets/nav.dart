import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sp_bill/features/login/presentation/blocs/login_bloc.dart';
import '../../core/common/constants.dart';
import '../../core/widgets/logout_btn.dart';
import '../../core/widgets/user_info.dart';

import 'menu_item.dart';

class NavBar extends StatelessWidget {
  final String userName;
  final int index;

  const NavBar({Key? key, required this.userName, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kGreenColor,
      child: Row(
        children: [
          InkWell(
            onTap: (){},
            child: Padding(
              padding: const EdgeInsets.only(top: 15.0, bottom: 15.0, left: 30.0, right: 75.0),
              child: Image.asset('assets/images/logo_nav.png', height: 34,),
            ),
          ),
          MenuItem(title: 'Thống kê', route: '/statistic', isActive: index == 5,),
          const Spacer(),
          UserInfo(name: userName),
          LogoutButton(onPressed: (){BlocProvider.of<LoginBloc>(context).add(LogoutButtonPress());}),
          const SizedBox(width: 10,),
        ],
      ),
    );
  }
}
