import 'package:flutter/material.dart';

import 'package:my_pokedex/generation.dart';

class GenerationList extends StatelessWidget {
  final Generation _generation;

  GenerationList(this._generation);

  @override
  Widget build(BuildContext buildContext) {
    final pokemonLinks = _generation.pokemonLinks == null ? [] : _generation.pokemonLinks;
    return ListView(children: pokemonLinks
      .map((pokemonLink) => pokemonLink.name)
      .map((pokemonName) => Material(child: ListTile(leading: Icon(Icons.photo), title: Text(pokemonName))))
      .toList());
  }
}
