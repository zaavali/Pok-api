import 'package:flutter/material.dart';


class PokemonDetailPage extends StatelessWidget {
  final Map<String, dynamic> pokemonDetails;

  const PokemonDetailPage(this.pokemonDetails, {super.key});

  @override
  Widget build(BuildContext context) {
    final int pokemonId = pokemonDetails['id'];
    final String speciesName = pokemonDetails['species'];


    final List<dynamic> types = pokemonDetails['types'];
    List<String> typeNames = types.map<String>((type) => type['type']['name'] as String).toList();

  
    final String description = pokemonDetails['description'];
    final List<dynamic> stats = pokemonDetails['stats'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Détails du Pokémon'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nom: ${pokemonDetails['name']}'),
            Text('Numéro: $pokemonId'),
            Text('Espèce: $speciesName'),
            Text('Types: ${typeNames.join(", ")}'),
            Text('Description: $description'),
            const Text('Statistiques:'),
            for (var stat in stats)
              Text('${stat['stat']['name']}: ${stat['base_stat']}'),
           
          ],
        ),
      ),
    );
  }
}

