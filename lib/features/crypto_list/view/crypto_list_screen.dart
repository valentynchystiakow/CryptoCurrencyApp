// import packages
import 'package:auto_route/annotations.dart';
import 'package:crypto_coins_list/features/crypto_list/bloc/crypto_list_bloc.dart';
import 'package:crypto_coins_list/features/crypto_list/widgets/crypto_coin_tile.dart';
import 'package:crypto_coins_list/repositories/crypto_coins/crypto_coins.dart';

// import libraries
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

// ads RoutePage annotation to CryptoListScreen
@RoutePage()
// Class CryptoListScreen - extends from StatefulWidget
class CryptoListScreen extends StatefulWidget {
  // class constructor
  const CryptoListScreen({super.key});
  // overrides state of CryptoListScreen
  @override
  State<CryptoListScreen> createState() => _CryptoListScreenState();
}

// class _MyHomePageState that extends from State
class _CryptoListScreenState extends State<CryptoListScreen> {
  // creates instance of CryptoListBloc with AbstractCoinsRepository
  final _cryptoListBloc = CryptoListBloc(GetIt.I<AbstractCoinsRepository>());

  // overrides method that automatically calls method that loads crypto coins info from api
  @override
  void initState() {
    // calls method that loads crypto list
    _cryptoListBloc.add(LoadCryptoList());
    // calls super method that initializes state
    super.initState();
  }

// overrides method that builds CryptoList Widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // widget attributes
        appBar: AppBar(
          title: const Text('CryptoCurrenciesList'),
          // ads action button that opens logging page
          actions: [
            IconButton(
                onPressed: () {
                  // push - method that creates navigation
                  Navigator.of(context).push(MaterialPageRoute(
                      // TalkerScreen - widget that shows logs
                      builder: (context) =>
                          TalkerScreen(talker: GetIt.I.call<Talker>())));
                },
                icon: const Icon(Icons.document_scanner_outlined))
          ],
        ),
        // creates List of Coins, BlockBuilder - class that builds widget, RefreshIndicator - widget that refreshes data
        body: RefreshIndicator(
          // calls method that reloads crypto list, works asynchronously because it works with api(requests to repository)
          onRefresh: () async {
            // creates instance of completer, Completer - class that tells that some async method(Future) is finished
            final completer = Completer();
            _cryptoListBloc.add(LoadCryptoList(completer: completer));
            return completer.future;
          },
          child: BlocBuilder<CryptoListBloc, CryptoListState>(
              bloc: _cryptoListBloc,
              builder: (context, state) {
                // if state is CryptoListLoaded
                if (state is CryptoListLoaded) {
                  return ListView.separated(
                    padding: const EdgeInsets.only(top: 16),
                    itemCount: state.coinsList.length,
                    // Divider - class that creates divider between list items
                    separatorBuilder: (context, index) => const Divider(),
                    itemBuilder: (context, i) {
                      final coin = state.coinsList[i];
                      return CryptoCoinTile(coin: coin);
                    },
                  );
                }
                // if state with error
                if (state is CryptoListLoadingFailure) {
                  // shows in Center widget error message
                  return Center(
                    // ads style to text
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Something went wrong',
                        ),
                        const Text(
                          'Please Try again later',
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        // creates button that calls method that reloads crypto list - makes request to repository again
                        TextButton(
                            onPressed: () {
                              _cryptoListBloc.add(LoadCryptoList());
                            },
                            child: const Text('Retry')),
                      ],
                    ),
                  );
                }
                // if state is CryptoListLoading shows CircularProgressIndicator
                return const Center(child: CircularProgressIndicator());
              }),
        ));
  }
}
