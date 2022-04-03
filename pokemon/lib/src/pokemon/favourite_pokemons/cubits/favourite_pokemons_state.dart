part of 'favourite_pokemons_cubit.dart';

enum FavouritePokemonStateStatus {
  loading,
  successful,
  error,
}

class FavouritePokemonsState extends Equatable {
  final Set<PokemonId> favouritePokemons;
  final FavouritePokemonStateStatus stateStatus;
  //this field here to differ states from each other.
  final int stateId;

  const FavouritePokemonsState({
    required this.favouritePokemons,
    required this.stateStatus,
    this.stateId = 0,
  });

  FavouritePokemonsState copyWith({
    Set<PokemonId>? favouritePokemons,
    FavouritePokemonStateStatus? stateStatus,
  }) {
    return FavouritePokemonsState(
      favouritePokemons: favouritePokemons ?? this.favouritePokemons,
      stateStatus: stateStatus ?? this.stateStatus,
      stateId: stateId + 1,
    );
  }

  @override
  List<Object?> get props => [
        stateStatus,
        stateId,
        stateStatus,
      ];
}
