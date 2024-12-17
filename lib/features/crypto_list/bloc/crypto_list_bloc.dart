// import packages
import 'package:crypto_coins_list/repositories/crypto_coins/abstract_coins_repository.dart';
import 'package:crypto_coins_list/repositories/crypto_coins/models/crypto_coin.dart';

// import libraries
import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

// import files parts
part 'crypto_list_event.dart';
part 'crypto_list_state.dart';

// creates CryptoListBloc that manages state of CryptoList, extends base class Bloc
class CryptoListBloc extends Bloc<CryptoListEvent, CryptoListState> {
  // class constructor
  CryptoListBloc(this.coinsRepository) : super(CryptoListInitial()) {
    on<LoadCryptoList>(_load);
  }
  // creates instance of AbstractCoinsRepository
  final AbstractCoinsRepository coinsRepository;
  // Future method that will load CryptoList, future always works async
  Future<void> _load(
    LoadCryptoList event,
    // emitter - emits state
    Emitter<CryptoListState> emit,
  ) async {
    try {
      // checks current state of cryptolist
      if (state is! CryptoListLoaded) {
        emit(CryptoListLoading());
      }
      final coinsList = await coinsRepository.getCoinsList();
      emit(CryptoListLoaded(coinsList: coinsList));
    } catch (e, st) {
      emit(CryptoListLoadingFailure(exception: e));
      GetIt.I<Talker>().handle(e, st);
    } finally {
      event.completer?.complete();
    }
  }

  // overrides method that handles error
  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    // uses Talker to handle errors and stackTraces
    GetIt.I<Talker>().handle(error, stackTrace);
  }
}
