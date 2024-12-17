// import packages
import 'package:crypto_coins_list/repositories/crypto_coins/models/crypto_coin.dart';

// creates abstract class that extends from AbstractCoinsRepository
abstract class AbstractCoinsRepository {
  Future<List<CryptoCoin>> getCoinsList();
  Future<CryptoCoin> getCoinDetails(String currencyCode);
}
