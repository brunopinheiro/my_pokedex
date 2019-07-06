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

PokemonLink _$PokemonLinkFromJson(Map<String, dynamic> json) {
  return PokemonLink(json['name'] as String, json['url'] as String);
}
