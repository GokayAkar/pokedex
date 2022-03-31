import 'package:pokemon_api/pokemon_repo.dart';

class PokemonRepo {
  final PokemonHttpHandler _httpHandler;
  final PokemonLocalStorageHandler _storageHandler;

  const PokemonRepo({
    required PokemonHttpHandler httpHandler,
    required PokemonLocalStorageHandler storageHandler,
  })  : _httpHandler = httpHandler,
        _storageHandler = storageHandler;

  Future<Pokemon> getPokemon(PokemonId id) async {
    final Map<String, dynamic> pokemonJson = await _storageHandler.readPokemon(id) ?? (await _httpHandler.fetchPokemonDetail(id));

    return Pokemon.fromJson(pokemonJson);
  }

  Future<PokemonPaginationResponse> getPokemonsToFetch({required int limit, required int offset}) async {
    final response = await _httpHandler.fetchPokemons(limit: limit, offset: offset);
    final pokemonsToFetch = <PriorPokemonInfo>[];

    for (final json in response['results']) {
      final id = (json['url'] as String).split('/').last;
      pokemonsToFetch.add(
        PriorPokemonInfo(
          name: json['name'],
          id: int.parse(id),
        ),
      );
    }

    return PokemonPaginationResponse(
      isLast: response['next'] != null,
      pokemons: pokemonsToFetch,
    );
  }

  Future<bool> updateFavorites(List<PokemonId> ids) async {
    return await _storageHandler.updateFavorites(ids);
  }

  Future<List<PokemonId>> getFavoritePokemons() async {
    return await _storageHandler.getFavorites();
  }
}
