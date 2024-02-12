import 'dart:convert';
import 'package:http/http.dart' as http;
import 'modelepokemon.dart';

Future<Map<String, dynamic>> fetchPokemonDetails(int id) async {
  final response = await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon/$id/'));
  if (response.statusCode == 200) {
    final pokemonData = jsonDecode(response.body);
  
    final speciesUrl = pokemonData['species']['url'];

    final speciesResponse = await http.get(Uri.parse(speciesUrl));
    if (speciesResponse.statusCode == 200) {
      final speciesData = jsonDecode(speciesResponse.body);
      return {
        'id': pokemonData['id'],
        'name': pokemonData['name'],
        'types': pokemonData['types'],
        'species': {
          'name': speciesData['name'],
         
        },
      };
    } else {
      throw Exception('Failed to load species data');
    }
  } else {
    throw Exception('Failed to load Pokemon data');
  }
}

Future<List<Pokemon>> fetchPokemonList() async {
  final response = await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon/?offset=0&limit=800'));
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    List<Pokemon> pokemonList = [];
    for (var pokemon in data['results']) {
      pokemonList.add(Pokemon(
        name: pokemon['name'],
        id: int.parse(pokemon['url'].split('/')[6]),
        types: [], 
      ));
    }
    return pokemonList;
  } else {
    throw Exception('Failed to load Pokemon list');
  }
}
