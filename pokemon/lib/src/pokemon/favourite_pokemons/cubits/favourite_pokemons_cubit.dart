import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_api/pokemon_repo.dart';
import 'package:equatable/equatable.dart';

part 'favourite_pokemons_state.dart';

class FavouritePokemonsCubit extends Cubit<FavouritePokemonsState> {
  final PokemonRepo _repo;
  final Set<PokemonId> _favorites = {};

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

      _favorites.addAll(favourites);

      emit(
        state.copyWith(
          favouritePokemons: _favorites,
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
    if (_favorites.contains(id)) {
      _favorites.remove(id);
    } else {
      _favorites.add(id);
    }

    emit(
      state.copyWith(
        favouritePokemons: _favorites,
      ),
    );

    final result = await _repo.updateFavorites(_favorites);

    if (result) {
      return;
    } else {
      if (_favorites.contains(id)) {
        _favorites.remove(id);
      } else {
        _favorites.add(id);
      }
      emit(
        state.copyWith(
          favouritePokemons: _favorites,
        ),
      );
    }
  }
}
