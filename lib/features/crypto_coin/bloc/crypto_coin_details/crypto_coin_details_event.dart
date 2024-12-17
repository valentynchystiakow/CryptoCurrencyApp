// part of crypto_coin_details_bloc
part of 'crypto_coin_details_bloc.dart';

// create abstract CryptoCoinDetailsEvent class that extends from Equatable, base class - should be abstract
abstract class CryptoCoinDetailsEvent extends Equatable {
  const CryptoCoinDetailsEvent();
  // overrides method that gets properties
  @override
  List<Object> get props => [];
}

// create class LoadCryptoCoinDetails that extends from CryptoCoinDetailsEvent
class LoadCryptoCoinDetails extends CryptoCoinDetailsEvent {
  // class constructor
  const LoadCryptoCoinDetails({
    required this.currencyCode,
  });

  final String currencyCode;
  // overrides method that gets properties
  @override
  List<Object> get props => super.props..add(currencyCode);
}
