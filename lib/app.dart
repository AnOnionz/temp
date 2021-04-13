import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sp_bill/features/login/presentation/blocs/authentication_bloc.dart';
import 'package:sp_bill/features/statistic/presentation/screens/users.dart';
import 'core/api/myDio.dart';
import 'features/login/presentation/screens/login_page.dart';
import 'responsive.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Responsive(
        mobile: Container(),
        tablet: Container(),
        desktop: BlocBuilder<AuthenticationBloc, AuthenticationState>(
              bloc: Modular.get<AuthenticationBloc>(),
              builder: (context, state) {
                if(state is AuthenticationAuthenticated){
                  Modular.get<CDio>().setBearerAuth(state.user.accessToken);
                  return Users();
                }
                return const LoginPage();
           },

        )
    );
  }
}
