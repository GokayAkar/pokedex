part of 'favourite_pokemons_cubit.dart';

enum FavouritePokemonStateStatus {
  loading,
  successful,
  error,
}

class FavouritePokemonsState {
  final Set<PokemonId> favouritePokemons;
  final FavouritePokemonStateStatus stateStatus;

  const FavouritePokemonsState({
    required this.favouritePokemons,
    required this.stateStatus,
  });

  FavouritePokemonsState copyWith({
    Set<PokemonId>? favouritePokemons,
    FavouritePokemonStateStatus? stateStatus,
  }) {
    return FavouritePokemonsState(
      favouritePokemons: favouritePokemons ?? this.favouritePokemons,
      stateStatus: stateStatus ?? this.stateStatus,
    );
  }
}
