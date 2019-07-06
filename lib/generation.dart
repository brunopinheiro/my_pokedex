import 'package:json_annotation/json_annotation.dart';

part 'generation.g.dart';

@JsonSerializable()
class Generation {
  @JsonKey(name: 'pokemon_species')
  final List<PokemonLink> pokemonLinks;

  Generation(this.pokemonLinks);

  factory Generation.fromJson(Map<String, dynamic> json) => _$GenerationFromJson(json);
}

@JsonSerializable()
class PokemonLink {
  final String name;
  final String url;

  PokemonLink(this.name, this.url);

  factory PokemonLink.fromJson(Map<String, dynamic> json) => _$PokemonLinkFromJson(json);
}
