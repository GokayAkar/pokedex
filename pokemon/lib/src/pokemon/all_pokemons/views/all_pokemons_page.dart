import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pokemon/src/pokemon/all_pokemons/cubits/all_pokemons_cubit.dart';
import 'package:pokemon_api/pokemon_repo.dart';

class AllPokemonsPage extends StatelessWidget {
  const AllPokemonsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pagingController = context.read<AllPokemonsCubit>().state.pagingController;
    return Scaffold(
      body: PagedGridView<int, PriorPokemonInfo>(
        pagingController: pagingController,
        builderDelegate: PagedChildBuilderDelegate(
          itemBuilder: (_, item, __) => SizedBox(
            child: Text(
              item.name,
            ),
          ),
        ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
      ),
    );
  }
}
