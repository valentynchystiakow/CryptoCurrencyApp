// import packages
import 'package:crypto_coins_list/repositories/crypto_coins/crypto_coins.dart';

// import libraries
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:talker_flutter/talker_flutter.dart';

// cypto coins repository class - handles http request that gets coins list and converts it to CryptoCoin model, extends from AbstractCoinsRepository
class CryptoCoinsRepository implements AbstractCoinsRepository {
  // class constructor
  CryptoCoinsRepository({
    required this.dio,
    required this.cryptoCoinsBox,
  });

  // creates instance of Dio
  final Dio dio;
  // creates instance of cryptoCoinsBox
  final Box<CryptoCoin> cryptoCoinsBox;

  // overrides Future method that gets coins list data from repository and saves it to cryptoCoinsBox(Hive storage)
  @override
  Future<List<CryptoCoin>> getCoinsList() async {
    var cryptoCoinsList = <CryptoCoin>[];
    // try catch block
    try {
      // creates list of crypto coins and puts there data from response from api
      cryptoCoinsList = await _fetchCoinsListFromApi();
      // converts coins list to map
      final cryptoCoinsMap = {for (var e in cryptoCoinsList) e.name: e};
      // puts map of coins to cryptoCoinsBox
      await cryptoCoinsBox.putAll(cryptoCoinsMap);
      // catches exceptions and stack traces
    } catch (e, st) {
      // creates talker instance to handle errors and stack traces, GetIt - package that provides dependency injection
      GetIt.instance<Talker>().handle(e, st);
      cryptoCoinsList = cryptoCoinsBox.values.toList();
    }
    // sorts coins list by price in usd
    cryptoCoinsList
        .sort((a, b) => b.details.priceInUSD.compareTo(a.details.priceInUSD));
    return cryptoCoinsList;
  }

  // future method that gets coins list from api
  Future<List<CryptoCoin>> _fetchCoinsListFromApi() async {
    // uses Dio package to make http requests, saves response data in response
    final response = await dio.get(
        'https://min-api.cryptocompare.com/data/pricemultifull?fsyms=BTC,ETH,BNB,AID,SOL,CAG,DOV&tsyms=USD');
    // debugPrint - method that prints data, while in debug mode
    // converts response data to map with sting keys and dynamic values
    final data = response.data as Map<String, dynamic>;
    // gets raw data from response and converts it to map
    final dataRaw = data['RAW'] as Map<String, dynamic>;
    // converts dataRaw values to CryptoCoin model using map method
    final cryptoCoinList = dataRaw.entries.map((e) {
      final usdData =
          (e.value as Map<String, dynamic>)['USD'] as Map<String, dynamic>;
      final details = CryptoCoinDetail.fromJson(usdData);
      return CryptoCoin(
        name: e.key,
        details: details,
      );
    }).toList();
    return cryptoCoinList;
  }

  // overrides Future method that gets data from repository for single coin page
  @override
  Future<CryptoCoin> getCoinDetails(String currencyCode) async {
    // try catch block
    try {
      // saves response data in coin
      final coin = await _fetchCoinDetails(currencyCode);
      cryptoCoinsBox.put(currencyCode, coin);
      return coin;
      // catches exceptions and stack traces
    } catch (e, st) {
      // create talker instance to handle errors and stack traces
      GetIt.instance<Talker>().handle(e, st);
      // gets coin details from cryptoCoinsBox by currencyCode key, ! - non-nullable
      return cryptoCoinsBox.get(currencyCode)!;
    }
  }

  // future method that gets data from api for single coin
  Future<CryptoCoin> _fetchCoinDetails(String currencyCode) async {
    // uses Dio package to make http requests
    final response = await dio.get(
        'https://min-api.cryptocompare.com/data/pricemultifull?fsyms=$currencyCode&tsyms=USD');
    // saves response data as map
    final data = response.data as Map<String, dynamic>;
    // gets raw data
    final dataRaw = data['RAW'] as Map<String, dynamic>;
    // gets coin data
    final coinData = dataRaw[currencyCode] as Map<String, dynamic>;
    // gets usd data
    final usdData = coinData['USD'] as Map<String, dynamic>;
    // converts usd data to coin details model
    final details = CryptoCoinDetail.fromJson(usdData);
    // returns coin details
    return CryptoCoin(name: currencyCode, details: details);
  }
}
