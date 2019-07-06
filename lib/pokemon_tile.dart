import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:my_pokedex/generation.dart';

class PokemonTile extends StatefulWidget {
  final PokemonTileState _state;

  PokemonTile(PokemonLink pokemonLink): _state = PokemonTileState(pokemonLink);

  @override
  PokemonTileState createState() => _state;
}

class PokemonTileState extends State<PokemonTile> {
  final PokemonLink _pokemonLink;

  PokemonTileState(this._pokemonLink);

  @override
  Widget build(BuildContext buildContext) {
    return Material(child: ListTile(title: Text(_pokemonLink.name)));
  }
}
