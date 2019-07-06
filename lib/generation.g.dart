// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Generation _$GenerationFromJson(Map<String, dynamic> json) {
  return Generation((json['pokemon_species'] as List)
      ?.map((e) =>
          e == null ? null : PokemonLink.fromJson(e as Map<String, dynamic>))
      ?.toList());
}

Map<String, dynamic> _$GenerationToJson(Generation instance) =>
    <String, dynamic>{'pokemon_species': instance.pokemonLinks};

PokemonLink _$PokemonLinkFromJson(Map<String, dynamic> json) {
  return PokemonLink(json['name'] as String, json['url'] as String);
}

Map<String, dynamic> _$PokemonLinkToJson(PokemonLink instance) =>
    <String, dynamic>{'name': instance.name, 'url': instance.url};
