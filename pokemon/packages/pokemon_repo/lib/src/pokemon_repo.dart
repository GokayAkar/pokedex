import 'package:pokemon_api/src/interfaces/cache_interface.dart';
import 'package:pokemon_api/src/interfaces/network_interface.dart';

import 'models/pokemon_model.dart';

class PokemonRepo {
  final PokemonHttpHandler _httpHandler;
  final PokemonLocalStorageHandler _storageHandler;

  const PokemonRepo({
    required PokemonHttpHandler httpHandler,
    required PokemonLocalStorageHandler storageHandler,
  })  : _httpHandler = httpHandler,
        _storageHandler = storageHandler;

  Future<Pokemon> getPokemon(PokemonId id) async {
    final Map<String, dynamic> pokemonJson = await _storageHandler.readPokemon(id) ?? (await _httpHandler.fetchPokemon(id));

    return Pokemon.fromJson(pokemonJson);
  }

  Future<bool> updateFavorites(List<PokemonId> ids) async {
    return await _storageHandler.updateFavorites(ids);
  }

  Future<List<PokemonId>> getFavoritePokemons() async {
    return await _storageHandler.getFavorites();
  }
}
