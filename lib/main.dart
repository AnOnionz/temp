import 'package:flutter/material.dart';
import 'package:asuka/asuka.dart' show builder;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sp_bill/simple_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:url_strategy/url_strategy.dart';
import 'app.dart';
import 'features/login/presentation/blocs/authentication_bloc.dart';
import 'features/login/presentation/blocs/login_bloc.dart';
import 'features/statistic/presentation/screens/users.dart';
import 'route/app_module.dart';

Future<void> main() async {
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
      theme: ThemeData(primarySwatch: Colors.teal),
      builder: builder,
      home: MyApp(),
    ).modular();
  }
}
