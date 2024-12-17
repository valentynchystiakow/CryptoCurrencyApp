// import packages(libraries)
import 'package:flutter/material.dart';
import 'package:crypto_coins_list/router/router.dart';
import 'package:crypto_coins_list/theme/theme.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

// class crypto currencies list app extends from stateful widget
class CryptoCurrenciesListApp extends StatefulWidget {
  // class constructor
  const CryptoCurrenciesListApp({super.key});
  // overrides method that creates state
  @override
  State<CryptoCurrenciesListApp> createState() =>
      _CryptoCurrenciesListAppState();
}

// create class that extends from state of crypto currencies list app
class _CryptoCurrenciesListAppState extends State<CryptoCurrenciesListApp> {
  // creates instance of approuter
  final _appRouter = AppRouter();
  // overrides method that builds widget with material app
  @override
  Widget build(BuildContext context) {
    // router - method that creates material app with app router
    return MaterialApp.router(
      title: 'CryptoCurrenciesList',
      theme: darkTheme,
      routerConfig: _appRouter.config(
        // creates route observer that logs navigation using talker
        navigatorObservers: () => [
          TalkerRouteObserver(GetIt.I<Talker>()),
        ],
      ),
    );
  }
}
