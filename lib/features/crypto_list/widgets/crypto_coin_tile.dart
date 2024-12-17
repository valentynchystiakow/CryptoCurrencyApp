// import packages
import 'package:auto_route/auto_route.dart';
import 'package:crypto_coins_list/router/router.dart';
import 'package:flutter/material.dart';

// import libraries
import 'package:crypto_coins_list/repositories/crypto_coins/models/crypto_coin.dart';

// class crypto coin tile
class CryptoCoinTile extends StatelessWidget {
  const CryptoCoinTile({
    super.key,
    required this.coin,
  });

  final CryptoCoin coin;
  // overrides method that builds Widget
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final coinDetails = coin.details;
    // returns list tile
    return ListTile(
      // gets coin image from api and shows it in leading pole, network - method that loads image from url
      leading: Image.network(coinDetails.fullImageUrl, height: 50, width: 50),
      // title
      title: Text(
        coin.name,
        style: theme.textTheme.bodyMedium,
      ),
      // subtitle - shows coin price in USD
      subtitle: Text(
        '${coinDetails.priceInUSD}\$',
        style: Theme.of(context).textTheme.labelSmall,
      ),
      // trailing icons
      trailing: const Icon(Icons.arrow_forward_ios),
      // onTap - creates tap event
      onTap: () {
        // Navigator -creates navigation, pushNamed  - method that creates navigation to named route
        AutoRouter.of(context).push(CryptoCoinRoute(coin: coin));
      },
    );
  }
}
