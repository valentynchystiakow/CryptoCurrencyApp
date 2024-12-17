// import packages
import 'package:crypto_coins_list/crypto_coins_list_app.dart';
import 'package:crypto_coins_list/firebase_options.dart';
import 'package:crypto_coins_list/repositories/crypto_coins/abstract_coins_repository.dart';
import 'package:crypto_coins_list/repositories/crypto_coins/crypto_coins_repository.dart';
import 'package:crypto_coins_list/repositories/crypto_coins/models/crypto_coin.dart';
import 'package:crypto_coins_list/repositories/crypto_coins/models/crypto_coin_details.dart';

// import libraries
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:talker_bloc_logger/talker_bloc_logger_observer.dart';
import 'package:talker_bloc_logger/talker_bloc_logger_settings.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'dart:async';

// main function that runs application
void main() async {
  // runs main app with error and stackTrace handling
  runZonedGuarded<Future<void>>(() async {
    // initializes widget binding
    WidgetsFlutterBinding.ensureInitialized();
    // initializes talker - class that provides extended logging functionality
    final talker = TalkerFlutter.init();
    // registers talker using GetIt
    GetIt.I.registerSingleton(talker);
    // initializes talker with global container, debug - method that prints debug messages
    GetIt.I<Talker>().debug('Talker started');

    // Hive key
    const cryptoCoinsBoxName = 'crypto_coins_box';

    // initializes Hive - library that provides key-value storage for Flutter apps
    await Hive.initFlutter();
    // registers created adapters
    Hive.registerAdapter(CryptoCoinAdapter());
    Hive.registerAdapter(CryptoCoinDetailAdapter());

    // creates box where coins data are stored, box initialization always works with async;
    final cryptoCoinsBox = await Hive.openBox<CryptoCoin>(cryptoCoinsBoxName);

    // initializes firebase, always works with async await
    final app = await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    // asks talker to log projectId - checks if app is initialized
    talker.info(app.options.projectId);

    // creates instance of Dio, Dio - library that makes http requests
    final dio = Dio();
    // ads TalkerDioLogger to interceptors, interceptors - class that intercepts http requests(kind of middleware)
    dio.interceptors.add(
        // library for logging Dio requests with Talker
        TalkerDioLogger(
            talker: talker,
            // loggins settings
            settings: const TalkerDioLoggerSettings(printResponseData: false)));

    // ads Bloc observer - method that handles state changes and logs them
    Bloc.observer = TalkerBlocObserver(
        talker: talker,
        // loggins settings
        settings: const TalkerBlocLoggerSettings(
            printStateFullData: false, printEventFullData: false));

    //GetIt - class that provides a global container for dependency injection, LazySingleton - registers lazy singletons, that creates instance when it is first requested
    GetIt.I.registerLazySingleton<AbstractCoinsRepository>(
        // registers repository using dio
        () => CryptoCoinsRepository(dio: dio, cryptoCoinsBox: cryptoCoinsBox));
    // runs mainApp
    runApp(const CryptoCurrenciesListApp());
    // FlutterError.onError - error handler that handles errors that cause grey or red screen
    FlutterError.onError =
        (details) => GetIt.I<Talker>().handle(details.exception, details.stack);
    (e, st) => GetIt.I<Talker>().handle(e, st);
  }, (e, st) => GetIt.I<Talker>().handle(e, st));
}
