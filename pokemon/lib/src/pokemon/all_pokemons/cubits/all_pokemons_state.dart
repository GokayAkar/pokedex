part of 'all_pokemons_cubit.dart';

class AllPokemonsState {
  final PagingController<int, PriorPokemonInfo> pagingController;

  const AllPokemonsState({
    required this.pagingController,
  });
}
