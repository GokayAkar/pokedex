import 'package:pokemon_api/pokemon_repo.dart';

class PokemonRepo {
  final PokemonHttpHandler _httpHandler;
  final PokemonLocalStorageHandler _storageHandler;

  PokemonRepo({
    PokemonHttpHandler? httpHandler,
    required PokemonLocalStorageHandler storageHandler,
  })  : _httpHandler = httpHandler ?? PokemonApiClient(),
        _storageHandler = storageHandler;

  Future<Pokemon> getPokemon(PokemonId id) async {
    final cachedPokemon = await _readPokemon(id);

    if (cachedPokemon != null) {
      return cachedPokemon;
    }

    final pokemonJson = await _httpHandler.fetchPokemonDetail(id);
    final imageUrl = pokemonJson['sprites']['other']['official-artwork']['front_default'];
    final stats = <PokemonStat>[];
    final types = <PokemonType>[];
    for (final statJson in pokemonJson['stats']) {
      stats.add(
        PokemonStat(
          name: (statJson['stat']['name'] as String).upperCaseFirstLetter,
          value: statJson['base_stat'],
        ),
      );
    }

    for (final typeJson in pokemonJson['types']) {
      types.add(
        PokemonType.fromString(
          name: (typeJson['type']['name'] as String).upperCaseFirstLetter,
        ),
      );
    }

    final pokemon = Pokemon(
      id: pokemonJson['id'],
      imageUrl: imageUrl,
      name: (pokemonJson['name'] as String).upperCaseFirstLetter,
      types: types,
      stats: stats,
      height: pokemonJson['height'],
      weight: pokemonJson['weight'],
    );

    _storageHandler.savePokemon(pokemon);

    return pokemon;
  }

  Future<PokemonPaginationResponse> getPokemonsToFetch({required int limit, required int offset}) async {
    final response = await _httpHandler.fetchPokemons(limit: limit, offset: offset);
    final pokemonsToFetch = <PriorPokemonInfo>[];

    for (final json in response['results']) {
      final seperatedUrl = (json['url'] as String).split('/');
      seperatedUrl.removeLast();
      final id = seperatedUrl.last;
      pokemonsToFetch.add(
        PriorPokemonInfo(
          name: json['name'],
          id: int.parse(id),
        ),
      );
    }

    return PokemonPaginationResponse(
      isLast: response['next'] == null,
      pokemons: pokemonsToFetch,
    );
  }

  Future<bool> updateFavorites(List<PokemonId> ids) async {
    return await _storageHandler.updateFavorites(ids);
  }

  Future<List<PokemonId>> getFavoritePokemons() async {
    return await _storageHandler.getFavorites();
  }

  Future<Pokemon?> _readPokemon(PokemonId id) async {
    try {
      final pokemonJson = await _storageHandler.readPokemon(id);
      if (pokemonJson != null) {
        return Pokemon.fromJson(pokemonJson);
      }

      return null;
    } catch (_) {
      // TODO log error
      return null;
    }
  }
}

extension UpperCaseFirstLetter on String {
  String get upperCaseFirstLetter => replaceFirst(this[0], this[0].toUpperCase());
}
