import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pokemon_api/pokemon_repo.dart';

part 'all_pokemons_state.dart';

class AllPokemonsCubit extends Cubit<AllPokemonsState> {
  final PagingController<int, PriorPokemonInfo> _pagingController;
  final PokemonRepo _repo;
  static const _limit = 12;

  AllPokemonsCubit({
    required PokemonRepo repo,
    required PagingController<int, PriorPokemonInfo> controller,
  })  : _repo = repo,
        _pagingController = controller,
        super(
          AllPokemonsState(
            pagingController: controller,
          ),
        ) {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPokemons(pageKey);
    });
  }

  @override
  Future<void> close() {
    _pagingController.dispose();
    return super.close();
  }

  Future<void> _fetchPokemons(int offset) async {
    try {
      final paginationResponse = await _repo.getPokemonsToFetch(limit: _limit, offset: offset);

      if (paginationResponse.isLast) {
        _pagingController.appendLastPage(paginationResponse.pokemons);
      } else {
        final nextPageKey = offset + paginationResponse.pokemons.length;
        _pagingController.appendPage(paginationResponse.pokemons, nextPageKey);
      }
    } catch (e) {
      debugPrint('error occured while trying to get paginated pokemons $e');
      //TODO log error
      _pagingController.error = e;
    }
  }
}
