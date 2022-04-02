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
            status: StateStatus.loading,
            pokemon: null,
          ),
        );

  Future<void> getPokemon() async {
    try {
      if (_pokedex.containsKey(_id)) {
        emit(
          PokemonDetailState(
            status: StateStatus.success,
            pokemon: _pokedex[_id],
          ),
        );
      }

      if (state.status != StateStatus.loading) {
        emit(
          const PokemonDetailState(
            status: StateStatus.loading,
            pokemon: null,
          ),
        );
      }

      final pokemon = await _repo.getPokemon(_id);
      _pokedex[_id] = pokemon;
      emit(
        PokemonDetailState(
          status: StateStatus.success,
          pokemon: pokemon,
        ),
      );
    } on PokemonNotFound catch (_) {
      emit(
        const PokemonDetailState(
          status: StateStatus.notFound,
          pokemon: null,
        ),
      );
    } on RequestFailed catch (e) {
      debugPrint(e.reason);
      //TODO log error
      emit(
        const PokemonDetailState(
          status: StateStatus.requestFailed,
          pokemon: null,
        ),
      );
    } catch (e) {
      debugPrint(e.toString());
      //TODO log error
      emit(
        const PokemonDetailState(
          status: StateStatus.unknownError,
          pokemon: null,
        ),
      );
    }
  }
}
