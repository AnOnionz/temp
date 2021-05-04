
import 'package:flutter/material.dart';
import 'package:asuka/asuka.dart' show builder;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sp_bill/simple_bloc.dart';
import 'package:url_strategy/url_strategy.dart';
import 'route/app_module.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();
  setPathUrlStrategy();
    runApp(
        ModularApp(
            module: AppModule(),
            child: App()
        )
    );
}

class App extends StatelessWidget {
  Map<int, Color> color =
  {
    50:Color.fromRGBO(10,105,13, .1),
    100:Color.fromRGBO(10,105,13, .2),
    200:Color.fromRGBO(10,105,13, .3),
    300:Color.fromRGBO(10,105,13, .4),
    400:Color.fromRGBO(10,105,13, .5),
    500:Color.fromRGBO(10,105,13, .6),
    600:Color.fromRGBO(10,105,13, .7),
    700:Color.fromRGBO(10,105,13, .8),
    800:Color.fromRGBO(10,105,13, .9),
    900:Color.fromRGBO(10,105,13, 1),
  };
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate
      ],
      supportedLocales: [
        const Locale('vi'),
      ],
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      title: "SP BILL",
      theme: ThemeData(primarySwatch: MaterialColor(0xFF0A690D, color), buttonColor: MaterialColor(0xFF0A690D, color)),
      builder: builder,
    ).modular();
  }
}
