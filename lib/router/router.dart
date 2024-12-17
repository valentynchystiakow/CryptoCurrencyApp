// import libraries
import 'package:auto_route/auto_route.dart';
import 'package:crypto_coins_list/features/crypto_coin/view/crypto_coin_screen.dart';
import 'package:crypto_coins_list/features/crypto_list/view/crypto_list_screen.dart';
import 'package:crypto_coins_list/repositories/crypto_coins/models/crypto_coin.dart';
import 'package:flutter/material.dart';
// import packages

// imports part of genrated file
part 'router.gr.dart';

// creates annotaion for autorouter configuration, _$ - means that this class if generated
@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  // overrides method that gets routes
  @override
  List<AutoRoute> get routes => [
        // crypto list route
        AutoRoute(page: CryptoListRoute.page, path: '/'),
        // detail crypto coin route
        AutoRoute(page: CryptoCoinRoute.page),
      ];
}
