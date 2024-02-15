import 'package:flutter/material.dart';
import 'pokemonapi.dart'; 
import 'modelepokemon.dart';
import 'detailspokemon.dart';

class PokemonListPage extends StatefulWidget {
  @override
  _PokemonListPageState createState() => _PokemonListPageState();
}

class _PokemonListPageState extends State<PokemonListPage> {
  late List<Pokemon> _pokemonList = [];
  late int _offset = 0;

  @override
  void initState() {
    super.initState();
    _loadPokemonList();
  }

  Future<void> _loadPokemonList() async {
    try {
      final List<Pokemon> pokemonList = await fetchPokemonList(offset: _offset);
      setState(() {
        _pokemonList.addAll(pokemonList);
      });
    } catch (e) {
      print('Error loading Pokemon list: $e');
    }
  }

  Future<void> _loadNextPage() async {
    setState(() {
      _offset += 20; // Load next 20 Pokemon
    });
    await _loadPokemonList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pokedex'),
      ),
      body: ListView.builder(
        itemCount: _pokemonList.length + 1,
        itemBuilder: (context, index) {
          if (index == _pokemonList.length) {
            return _buildLoadMoreButton();
          } else {
            final pokemon = _pokemonList[index];
            final imageUrl = 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${pokemon.id}.png';
            return ListTile(
              leading: Image.network(imageUrl),
              title: Text(pokemon.name),
              subtitle: Text('Number: ${pokemon.id}, Types: ${pokemon.types.join(", ")}'),
              onTap: () => _showPokemonDetails(pokemon),
            );
          }
        },
      ),
    );
  }

  Widget _buildLoadMoreButton() {
    return Center(
      child: ElevatedButton(
        onPressed: _loadNextPage,
        child: Text('Load More'),
      ),
    );
  }

  void _showPokemonDetails(Pokemon pokemon) {
    fetchPokemonDetails(pokemon.id).then((details) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PokemonDetailPage(details)),
      );
    }).catchError((error) {
      print('Error fetching Pokemon details: $error');
    });
  }
}

