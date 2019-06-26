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
  PokeListState(Api api): _api = api;

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Loading...'));
  }
}

