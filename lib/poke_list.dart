import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:my_pokedex/api.dart';

class PokeList extends StatefulWidget {
  final PokeListState _state;
  PokeList(Api api): _state = new PokeListState(api);

  @override
  PokeListState createState() => _state;
}

class PokeListState extends State<PokeList> {
  final Api _api;
  PokeListViewState _viewState;
  StreamSubscription _fetchSubscription;

  PokeListState(Api api): _api = api;

  @override
  void initState() {
    super.initState();
    _viewState = PokeListViewState.loading;
    fetchPokemonList();
  }

  void fetchPokemonList() {
    _fetchSubscription = _api
      .request('generation')
      .listen(
        (_) => setState(() { _viewState = PokeListViewState.success; }),
        onError: (_) => setState(() { _viewState = PokeListViewState.error; })
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pokédex')),
      body: getBody(),
      );
  }

  Widget getBody() {
    switch(_viewState) {
      case PokeListViewState.error: return getErrorStateWidget(); 
      case PokeListViewState.success: return getListStateWidget();
      default: return getLoadingStateWidget(); 
    }
  }

  Widget getErrorStateWidget() {
    return Column(
      children: [
        Text('Something went wrong. Please, try again'),
        IconButton(icon: Icon(Icons.replay), onPressed: (){
          setState(() { _viewState = PokeListViewState.loading; });
          fetchPokemonList();
        })
      ],
      mainAxisAlignment: MainAxisAlignment.center,
    );
  }

  Widget getListStateWidget() {
    return Center(child: Text('Success...'));
  }

  Widget getLoadingStateWidget() {
    return Row(
      children: [
        CircularProgressIndicator(),
        Container(width: 10),
        Text('Loading...')
      ],
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
    );
  }

  @override
  void dispose() {
    _fetchSubscription.cancel();
    super.dispose();
  }
}

enum PokeListViewState {
  loading,
  success,
  error
}