import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pokemon/src/pokemon/all_pokemons/cubits/all_pokemons_cubit.dart';
import 'package:pokemon/src/pokemon/all_pokemons/views/all_pokemons_page.dart';
import 'package:pokemon/src/pokemon/favourite_pokemons/favourite_pokemons.dart';
import 'package:pokemon/src/pokemon/favourite_pokemons/views/views.dart';

import 'package:pokemon/src/pokemon/home/home.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  static const routeName = '/allPokemons';

  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PokedexAppBar(
          bottom: PokedexTabBar(),
        ),
        body: TabBarView(
          children: [
            AllPokemonsPage(),
            FavouritePokemonsPage(),
          ],
        ),
      ),
    );
  }
}
