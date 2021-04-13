import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sp_bill/features/login/presentation/blocs/authentication_bloc.dart';
import 'package:sp_bill/features/statistic/presentation/screens/users.dart';


import 'core/api/myDio.dart';
import 'di.dart';
import 'features/login/presentation/blocs/login_bloc.dart';
import 'features/login/presentation/screens/login_page.dart';
import 'responsive.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Responsive(
      mobile: Container(),
      tablet: Container(),
      desktop: MultiBlocProvider(
        providers: [
          BlocProvider<AuthenticationBloc>(create: (_) => sl<AuthenticationBloc>()..add(AppStarted())),
          BlocProvider<LoginBloc>(create: (_) => sl<LoginBloc>()),
        ], child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if(state is AuthenticationAuthenticated){
            sl<CDio>().setBearerAuth(state.user.accessToken);
            return Users();
          }
          return LoginPage();
        },

      ),
      )
    );
  }
}
