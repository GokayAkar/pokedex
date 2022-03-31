import 'dart:async';

import 'package:pokemon_api/src/models/pokemon_model.dart';

abstract class PokemonLocalStorageHandler {
  FutureOr<bool> savePokemon(Pokemon pokemon);
  FutureOr<Map<String, dynamic>?>? readPokemon(PokemonId id);
  FutureOr<bool> updateFavorites(List<PokemonId> ids);
  FutureOr<List<PokemonId>> getFavorites();
}
