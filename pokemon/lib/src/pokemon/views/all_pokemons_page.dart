import 'package:flutter/material.dart';
import 'package:pokemon/src/pokemon/pokemon.dart';

class AllPokemonsPage extends StatelessWidget {
  const AllPokemonsPage({
    Key? key,
  }) : super(key: key);

  static const routeName = '/allPokemons';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: PokedexAppBar(),
      body: PokeBall(),
    );
  }
}
