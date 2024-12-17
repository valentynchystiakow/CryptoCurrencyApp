// import libraires packages
import 'package:auto_route/auto_route.dart';
import 'package:crypto_coins_list/features/crypto_coin/bloc/crypto_coin_details/crypto_coin_details_bloc.dart';
import 'package:crypto_coins_list/features/crypto_coin/widgets/widgets.dart';
import 'package:crypto_coins_list/repositories/crypto_coins/crypto_coins.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

// creates annotaion for router page
@RoutePage()
class CryptoCoinScreen extends StatefulWidget {
  const CryptoCoinScreen({
    super.key,
    required this.coin,
  });
  // creates instance of CryptoCoin
  final CryptoCoin coin;
  // overrides method that creates state of CryptoCoinScreen
  @override
  State<CryptoCoinScreen> createState() => _CryptoCoinScreenState();
}

// creates class that extends from CryptoCoinScreen state
class _CryptoCoinScreenState extends State<CryptoCoinScreen> {
  // CryptoCoin? coin;
  // creates instance of CryptoCoinDetailsBloc
  final _coinDetailsBloc = CryptoCoinDetailsBloc(
    GetIt.I<AbstractCoinsRepository>(),
  );
  // overrides method than initializes CoinDetails state
  @override
  void initState() {
    _coinDetailsBloc.add(LoadCryptoCoinDetails(currencyCode: widget.coin.name));
    super.initState();
  }

  // With using AutoRoutes we dont need to use this structure anymore
  // @override
  // void didChangeDependencies() {
  //   final args = ModalRoute.of(context)?.settings.arguments;
  //   assert(args != null && args is CryptoCoin, 'You must provide String args');
  //   coin = args as CryptoCoin;
  //   _coinDetailsBloc.add(LoadCryptoCoinDetails(currencyCode: coin!.name));
  //   super.didChangeDependencies();
  // }

// overrides method that builds Widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bar with return to list of coins button
      appBar: AppBar(),
      // body with coin info
      body: BlocBuilder<CryptoCoinDetailsBloc, CryptoCoinDetailsState>(
        bloc: _coinDetailsBloc,
        builder: (context, state) {
          if (state is CryptoCoinDetailsLoaded) {
            final coin = state.coinDetails;
            final coinDetails = coin.details;
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 160,
                    width: 160,
                    child: Image.network(coinDetails.fullImageUrl),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    coin.name,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  BaseCard(
                    child: Center(
                      child: Text(
                        '${coinDetails.priceInUSD} \$',
                        style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  BaseCard(
                    child: Column(
                      children: [
                        _DataRow(
                          title: 'Hight 24 Hour',
                          value: '${coinDetails.hight24Hour} \$',
                        ),
                        const SizedBox(height: 6),
                        _DataRow(
                          title: 'Low 24 Hour',
                          value: '${coinDetails.low24Hours} \$',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

// creates class that extends from StatelessWidget
class _DataRow extends StatelessWidget {
  const _DataRow({
    required this.title,
    required this.value,
  });

  final String title;
  final String value;
  // overrides method that builds widget
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(width: 140, child: Text(title)),
        const SizedBox(width: 32),
        Flexible(
          child: Text(value),
        ),
      ],
    );
  }
}
