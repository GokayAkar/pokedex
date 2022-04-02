import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pokemon/src/pokemon/all_pokemons/cubits/all_pokemons_cubit.dart';
import 'package:pokemon/src/pokemon/all_pokemons/views/all_pokemons_page.dart';

import 'package:pokemon/src/pokemon/home/home.dart';
import 'package:pokemon_api/pokemon_repo.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  static const routeName = '/allPokemons';

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AllPokemonsCubit>(
      create: (_) => AllPokemonsCubit(
        controller: PagingController(firstPageKey: 0),
        repo: context.read<PokemonRepo>(),
      ),
      child: const DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: PokedexAppBar(
            bottom: PokedexTabBar(),
          ),
          body: TabBarView(
            children: [
              AllPokemonsPage(),
              Icon(Icons.directions_transit),
            ],
          ),
        ),
      ),
    );
  }
}
