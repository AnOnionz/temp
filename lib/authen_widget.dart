import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sp_bill/responsive.dart';
import 'core/api/myDio.dart';
import 'features/login/presentation/blocs/authentication_bloc.dart';
import 'features/login/presentation/screens/login_page.dart';


class AuthenticateWidget extends StatelessWidget {
  final Widget child;

  const AuthenticateWidget({Key? key,required this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Responsive(
        mobile: Container(),
        tablet: Container(),
        desktop: BlocProvider(
        create: (context) => Modular.get<AuthenticationBloc>()..add(AppStarted()),
        child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            if(state is AuthenticationAuthenticated){
              Modular.get<CDio>().setBearerAuth(state.user.accessToken);
              return child;
            }
            if(state is AuthenticationUnauthenticated){
              return const LoginPage();
            }
            return Center(child: Container(
                height: 50,
                width: 50,
                child: CircularProgressIndicator()));
          },
        ),
      ),
    );
  }
}
