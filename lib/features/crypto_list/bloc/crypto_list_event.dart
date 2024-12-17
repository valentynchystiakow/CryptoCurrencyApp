// part of - tells that this file is part of crypto_list_bloc
part of 'crypto_list_bloc.dart';

// abstract class CryptoListState - base event should be abstract,extends from Equatable
abstract class CryptoListEvent extends Equatable {}

// class that loads cryptolist - extends from CryptoListEvent
class LoadCryptoList extends CryptoListEvent {
  // class constructor
  LoadCryptoList({this.completer});
  // ? - means that completer can be null, Completer - class that tells that some async method(Future) is finished
  final Completer? completer;
  // overrides get props method
  @override
  // gets completer
  List<Object?> get props => [completer];
}
