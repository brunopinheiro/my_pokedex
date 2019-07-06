import 'package:flutter/material.dart';

import 'package:my_pokedex/generation.dart';
import 'package:my_pokedex/pokemon_tile.dart';

class GenerationList extends StatelessWidget {
  final Generation _generation;

  GenerationList(this._generation);

  @override
  Widget build(BuildContext buildContext) {
    List<PokemonLink> pokemonLinks = _generation.pokemonLinks == null ? [] : _generation.pokemonLinks;
    pokemonLinks.sort((p1, p2) => p1.name.compareTo(p2.name));

    return ListView.builder(
      itemCount: pokemonLinks.length,
      itemBuilder: (_, int index) => PokemonTile(pokemonLinks[index]),
    );
  }
}
