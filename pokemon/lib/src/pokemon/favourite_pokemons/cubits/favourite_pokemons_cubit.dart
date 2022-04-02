import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_api/pokemon_repo.dart';

part 'favourite_pokemons_state.dart';

class FavouritePokemonsCubit extends Cubit<FavouritePokemonsState> {
  final PokemonRepo _repo;

  FavouritePokemonsCubit({
    required PokemonRepo repo,
  })  : _repo = repo,
        super(
          const FavouritePokemonsState(
            stateStatus: FavouritePokemonStateStatus.loading,
            favouritePokemons: {},
          ),
        ) {
    getFavourites();
  }

  @override
  emit(FavouritePokemonsState state) {
    if (isClosed) {
      return;
    }
    super.emit(state);
  }

  Future<void> getFavourites() async {
    try {
      if (state.stateStatus != FavouritePokemonStateStatus.loading) {
        emit(state.copyWith(stateStatus: FavouritePokemonStateStatus.loading));
      }
      final favourites = await _repo.getFavoritePokemons();

      emit(
        state.copyWith(
          favouritePokemons: favourites,
          stateStatus: FavouritePokemonStateStatus.successful,
        ),
      );
    } catch (e) {
      debugPrint(e.toString());
      //TODO log error

      emit(
        state.copyWith(
          stateStatus: FavouritePokemonStateStatus.error,
        ),
      );
    }
  }

  Future<void> updateFavourites(PokemonId id) async {
    if (state.favouritePokemons.contains(id)) {
      state.favouritePokemons.remove(id);
    } else {
      state.favouritePokemons.add(id);
    }

    emit(
      state.copyWith(
        favouritePokemons: state.favouritePokemons,
      ),
    );

    final result = await _repo.updateFavorites(state.favouritePokemons);

    if (result) {
      return;
    } else {
      if (state.favouritePokemons.contains(id)) {
        state.favouritePokemons.remove(id);
      } else {
        state.favouritePokemons.add(id);
      }
      emit(
        state.copyWith(
          favouritePokemons: state.favouritePokemons,
        ),
      );
    }
  }
}
