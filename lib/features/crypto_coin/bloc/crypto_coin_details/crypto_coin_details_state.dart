// this is part of crypto_coin_details_bloc
part of 'crypto_coin_details_bloc.dart';

// creates abstract class CryptoCoinDetailsState that extends from Equatable
class CryptoCoinDetailsState extends Equatable {
  const CryptoCoinDetailsState();
  // method that overrides get props method
  @override
  List<Object?> get props => [];
}

// create CoinDetailsLoading state class that extends from CryptoCoinDetailsState
class CryptoCoinDetailsLoading extends CryptoCoinDetailsState {
  const CryptoCoinDetailsLoading();
}

// create CoinDetailsLoaded state class that extends from CryptoCoinDetailsState
class CryptoCoinDetailsLoaded extends CryptoCoinDetailsState {
  // class constructor
  const CryptoCoinDetailsLoaded(this.coinDetails);
  // create instance of detailed coin
  final CryptoCoin coinDetails;
  // method that overrides get props method
  @override
  List<Object?> get props => [coinDetails];

  get coin => null;
}

// create CoinDetailsLoaded state class that extends from CryptoCoinDetailsState
class CryptoCoinDetailsLoadingFailure extends CryptoCoinDetailsState {
  const CryptoCoinDetailsLoadingFailure(this.exception);
  // create instance of exception
  final Object exception;
// overrides method that gets props
  @override
  List<Object?> get props => super.props..add(exception);
}
