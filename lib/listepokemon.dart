import 'package:flutter/material.dart';
import 'pokemonapi.dart'; 
import 'modelepokemon.dart';
import 'detailspokemon.dart';

class PokemonListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pokedex'),
      ),
      body: FutureBuilder<List<Pokemon>>(
        future: fetchPokemonList(),
        builder: (context, AsyncSnapshot<List<Pokemon>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {

            List<Pokemon>? pokemonList = snapshot.data;
            return ListView.builder(
              itemCount: pokemonList?.length ?? 0,
              itemBuilder: (context, index) {
                final pokemon = pokemonList?[index];
                final imageUrl =
                    'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${pokemon?.id}.png';
                return ListTile(
                  leading: Image.network(imageUrl),
                  title: Text(pokemon!.name),
                  onTap: () {
                    fetchPokemonDetails(pokemon.id).then((details) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PokemonDetailPage(details)),
                      );
                    }).catchError((error) {
                      print('Error fetching Pokemon details: $error');
                    });
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
