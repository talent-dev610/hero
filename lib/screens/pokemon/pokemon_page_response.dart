// {
//   "count": 1126,
//   "next": "https://pokeapi.co/api/v2/pokemon?offset=300&limit=100",
//   "previous": "https://pokeapi.co/api/v2/pokemon?offset=100&limit=100",
//   "results": [
//     {
//       "name": "unown",
//       "url": "https://pokeapi.co/api/v2/pokemon/201/"
//     },
//     {
//       "name": "wobbuffet",
//       "url": "https://pokeapi.co/api/v2/pokemon/202/"
//     },
//     {
//       "name": "girafarig",
//       "url": "https://pokeapi.co/api/v2/pokemon/203/"
//     },

import 'package:flutter/foundation.dart';

class PokemonListing {
  final int id;
  final String name;

  PokemonListing(@required this.id, @required this.name);

  factory PokemonListing.fromJson(Map<String, dynamic> json) {
    final name = json['name'];
    final url = json['url'] as String;
    final id = int.parse(url.split('/')[6]);
    return PokemonListing(id, name);
  }
}

class PokemonPageResponse {
  final List<PokemonListing> pokemonListings;
  final bool canLoadNextPage;

  PokemonPageResponse(this.pokemonListings, this.canLoadNextPage);

  factory PokemonPageResponse.fromJson(Map<String, dynamic> json) {
    final canLoadNextPage = json['next'] != null;
    final pokemonListings = (json['results'] as List)
        .map((listingJson) => PokemonListing.fromJson(listingJson))
        .toList();

    return PokemonPageResponse(pokemonListings, canLoadNextPage);
  }
}
