import 'package:flutter/material.dart';

class PokemonDetailPage extends StatelessWidget {
  final Map<String, dynamic> pokemonDetails;

  const PokemonDetailPage(this.pokemonDetails, {Key? key}) : super(key: key);

  
  Color getColorForType(String typeName) {
    
    switch (typeName) {
      case 'normal':
        return Colors.brown;
      case 'fire':
        return Colors.red;
      case 'water':
        return Colors.blue;
      case 'grass':
        return Colors.green;

      case 'flying':
        return Colors.lightGreen;

      case 'poison':
        return Colors.purple;

      case 'dragon':
        return const Color.fromARGB(255, 124, 77, 255);

      case 'fairy':
        return const Color.fromARGB(255, 219, 11, 191);

      case 'ground':
        return Colors.brown;
      case 'fighting':
        return Colors.brown;

      case 'rock':
        return Colors.grey;

      case 'psychic':
        return Colors.pink;

      case 'electric':
        return Colors.yellow;

      case 'ice':
        return Colors.cyan;

      case 'ghost':
        return Colors.deepPurple;

      case 'dark':
        return const Color.fromARGB(255, 60, 7, 85);

      case 'steel':
        return const Color.fromARGB(255, 73, 73, 73);
        
      
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final int pokemonId = pokemonDetails['id'];
    final String speciesName = pokemonDetails['species'];

    final List<dynamic> types = pokemonDetails['types'];
    List<String> typeNames =
        types.map<String>((type) => type['type']['name'] as String).toList();

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
            Text(
              'Nom: ${pokemonDetails['name']}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: getColorForType(typeNames[0]), 
              ),
            ),
            Text(
              'Numéro: $pokemonId',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: getColorForType(typeNames[0]), 
              ),
            ),
            Text(
              'Espèce: $speciesName',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: getColorForType(typeNames[0]), 
              ),
            ),
            Text(
              'Types: ${typeNames.join(", ")}',
              style: TextStyle(
                fontStyle: FontStyle.italic,
                color: getColorForType(typeNames[0]), 
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Description: $description',
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ),
            const Text(
              'Statistiques:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            for (var stat in stats)
              Text(
                '${stat['stat']['name']}: ${stat['base_stat']}',
                style: TextStyle(
                  color: getColorForType(typeNames[0]), 
                ),
              ),
          ],
        ),
      ),
    );
  }
}

