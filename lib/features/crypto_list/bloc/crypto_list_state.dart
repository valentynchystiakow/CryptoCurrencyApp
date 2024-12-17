// part of - tells that this file is part of crypto_list_bloc
part of 'crypto_list_bloc.dart';

// class CryptoListState, Equatable - class that checks if two states are equal
abstract class CryptoListState extends Equatable {}

// class CryptoListInitial that handles state that initializes data
class CryptoListInitial extends CryptoListState {
  // method that overrides equatable
  @override
  // gets empty list
  List<Object?> get props => [];
}

// class CryptoListLoading that handles state when data is loading
class CryptoListLoading extends CryptoListState {
  // method that overrides equatable
  @override
  // gets empty list
  List<Object?> get props => [];
}

// class CryptoListLoaded that handles state when data is loaded
class CryptoListLoaded extends CryptoListState {
  // class constructor
  CryptoListLoaded({required this.coinsList});

  final List<CryptoCoin> coinsList;
  // method that overrides equatable
  @override
  // gets coins list
  List<Object?> get props => [coinsList];
}

// class with Error State extends from main CryptoListState
class CryptoListLoadingFailure extends CryptoListState {
  // class constructor
  CryptoListLoadingFailure({required this.exception});
  // ? - means it can be null
  final Object? exception;
  // method that overrides equatable
  @override
  // throws exception
  List<Object?> get props => [exception];
}
