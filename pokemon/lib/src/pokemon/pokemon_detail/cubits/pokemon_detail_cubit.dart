import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_api/pokemon_repo.dart';

part 'pokemon_detail_state.dart';

class PokemonDetailCubit extends Cubit<PokemonDetailState> {
  final PokemonRepo _repo;
  final PokemonId _id;
  final Map<PokemonId, Pokemon> _pokedex;

  PokemonDetailCubit({
    required PokemonRepo repo,
    required PokemonId id,
    required Map<PokemonId, Pokemon> pokedex,
  })  : _repo = repo,
        _id = id,
        _pokedex = pokedex,
        super(
          const PokemonDetailState(
            status: PokemonDetailStateStatus.loading,
            pokemon: null,
          ),
        ) {
    getPokemon();
  }

  @override
  emit(PokemonDetailState state) {
    if (isClosed) {
      return;
    }
    super.emit(state);
  }

  Future<void> getPokemon() async {
    try {
      if (_pokedex.containsKey(_id)) {
        emit(
          PokemonDetailState(
            status: PokemonDetailStateStatus.success,
            pokemon: _pokedex[_id],
          ),
        );
      }

      if (state.status != PokemonDetailStateStatus.loading) {
        emit(
          const PokemonDetailState(
            status: PokemonDetailStateStatus.loading,
            pokemon: null,
          ),
        );
      }

      final pokemon = await _repo.getPokemon(_id);
      _pokedex[_id] = pokemon;
      emit(
        PokemonDetailState(
          status: PokemonDetailStateStatus.success,
          pokemon: pokemon,
        ),
      );
    } on PokemonNotFound catch (_) {
      emit(
        const PokemonDetailState(
          status: PokemonDetailStateStatus.notFound,
          pokemon: null,
        ),
      );
    } on RequestFailed catch (e) {
      debugPrint(e.reason);
      //TODO log error
      emit(
        const PokemonDetailState(
          status: PokemonDetailStateStatus.requestFailed,
          pokemon: null,
        ),
      );
    } catch (e) {
      debugPrint(e.toString());
      //TODO log error

      emit(
        const PokemonDetailState(
          status: PokemonDetailStateStatus.unknownError,
          pokemon: null,
        ),
      );
    }
  }
}
