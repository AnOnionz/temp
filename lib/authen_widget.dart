import 'dart:html' as html;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sp_bill/core/common/constants.dart';
import 'package:sp_bill/responsive.dart';
import '404.dart';
import 'core/api/myDio.dart' as dio;
import 'features/login/presentation/blocs/authentication_bloc.dart';
import 'features/login/presentation/screens/login_page.dart';



class AuthenticateWidget extends StatefulWidget {
  final Widget child;

  const AuthenticateWidget({Key key,@required this.child}) : super(key: key);

  @override
  _AuthenticateWidgetState createState() => _AuthenticateWidgetState();
}

class _AuthenticateWidgetState extends State<AuthenticateWidget> {



  // Future<void> _onPointerDown(PointerDownEvent event) async {
  //   // Check if right mouse button clicked
  //   if (event.kind == PointerDeviceKind.mouse &&
  //       event.buttons == kSecondaryMouseButton) {
  //     final overlay =
  //     Overlay.of(context)
  //         .context
  //         .findRenderObject() as RenderBox;
  //         final menuItem = await showMenu<int>(
  //         shape: RoundedRectangleBorder(
  //             borderRadius: BorderRadius.circular(5.0)
  //         ),
  //         context: context,
  //         elevation: 20,
  //         useRootNavigator: true,
  //         items: [
  //           PopupMenuItem(
  //               child: PopupItem(color: Colors.white, icon: Icon(Icons.table_view, color: kGreyColor,),text: 'xuất excel',callback: (){
  //             exportExcel(data: []);
  //
  //           })),
  //         ],
  //         position: RelativeRect.fromSize(
  //             event.position & Size(48.0, 48.0), overlay.size));
  //         AuthenticationBloc.isPopup = true;
  //   }
  // }

  @override
  void initState() {
    html.document.onContextMenu.listen((event) => event.preventDefault());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
        onPointerDown: null,//_onPointerDown,
        child: FocusableActionDetector(
        autofocus: true,
        child: Responsive(
        mobile: ErrorPage(),
        tablet: ErrorPage(),
        desktop: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          bloc: Modular.get<AuthenticationBloc>()..add(AppStarted()),
          builder: (context, state) {
            if(state is AuthenticationAuthenticated){
              Modular.get<dio.CDio>().setBearerAuth(state.user.accessToken);
              return widget.child;
            }
            if(state is AuthenticationUnauthenticated){
              return const LoginPage();
            }
            return Container(
              color: Colors.white,
                child: Center(child: Image.asset('assets/images/loading.png', height: 250, width: 250,)));
          },
        ),
      ),
    ),
    );
  }
}
class PopupItem extends StatelessWidget {
  final Color color;
  final Icon icon;
  final String text;
  final VoidCallback callback;

  const PopupItem({Key key, @required this.color, @required this.icon, @required this.callback, @required this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callback,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: color,
        ),
        child: Row(
          children: [
            icon,
            Text(text, style: kTealText,)
          ],
        ),
      ),
    );
  }
}

