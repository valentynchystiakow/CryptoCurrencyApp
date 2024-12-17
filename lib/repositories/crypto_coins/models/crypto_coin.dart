// import packages
import 'package:crypto_coins_list/repositories/crypto_coins/models/crypto_coin_details.dart';
// import libraries
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';

// import part of file with generated data
part 'crypto_coin.g.dart';

// creates HiveType annotation - that creates hive adapter
@HiveType(typeId: 2)
// CryptoCoin model class that extends from Equatable, Equtable- class that checks if two instances are equal
class CryptoCoin extends Equatable {
  // constructor - lets to create intances of CryptoCoin
  const CryptoCoin({required this.name, required this.details});
  // model poles
  // creates HiveField annotation for coin name
  @HiveField(0)
  final String name;
  // creates HiveField annotation for coin detailed
  @HiveField(1)
  final CryptoCoinDetail details;

  // overrides get props method
  @override
  // gets model properties
  List<Object?> get props => [name, details];
}
