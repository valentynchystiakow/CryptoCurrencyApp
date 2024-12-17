// import packages
import 'package:crypto_coins_list/repositories/crypto_coins/abstract_coins_repository.dart';
import 'package:crypto_coins_list/repositories/crypto_coins/models/crypto_coin.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import libraries
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

// import file parts
part 'crypto_coin_details_event.dart';
part 'crypto_coin_details_state.dart';

// creates class that extends from BLoC, BloC - is state management system
class CryptoCoinDetailsBloc
    extends Bloc<CryptoCoinDetailsEvent, CryptoCoinDetailsState> {
  // class constructor
  CryptoCoinDetailsBloc(this.coinsRepository)
      : super(const CryptoCoinDetailsState()) {
    on<LoadCryptoCoinDetails>(_load);
  }
  // creates instance of AbstractCoinsRepository
  final AbstractCoinsRepository coinsRepository;

  // creates Future method that loads crypto coin details, future always works async
  Future<void> _load(
    // event
    LoadCryptoCoinDetails event,
    // emits new state
    Emitter<CryptoCoinDetailsState> emit,
  ) async {
    // try catch block
    try {
      // checks state
      if (state is! CryptoCoinDetailsLoaded) {
        // emits new state
        emit(const CryptoCoinDetailsLoading());
      }
      // loads crypto coin details from repository
      final coinDetails =
          await coinsRepository.getCoinDetails(event.currencyCode);
      // after getting details emits new state
      emit(CryptoCoinDetailsLoaded(coinDetails));
      // catches error if they are
    } catch (e, st) {
      // emits state with errors
      emit(CryptoCoinDetailsLoadingFailure(e));
      // uses Talker to handle errors and stack traces
      GetIt.I<Talker>().handle(e, st);
    }
  }

  // overrides method that handles errors and stackTraces
  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    // uses Talker to hanlde errors
    GetIt.I<Talker>().handle(error, stackTrace);
  }
}
