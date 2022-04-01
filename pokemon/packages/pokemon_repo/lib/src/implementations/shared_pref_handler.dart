import 'dart:convert';

import 'package:pokemon_api/src/interfaces/cache_interface.dart';
import 'package:pokemon_api/src/models/pokemon_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesCacheHandler implements PokemonLocalStorageHandler {
  final SharedPreferences _prefs;

  static const favoritesKey = 'favorites';

  const SharedPreferencesCacheHandler({required SharedPreferences prefs}) : _prefs = prefs;

  @override
  Map<String, dynamic>? readPokemon(PokemonId id) {
    try {
      if (_prefs.containsKey(id.toString())) {
        return json.decode(_prefs.getString(id.toString()) ?? "");
      }
      return null;
    } catch (e) {
      // TODO log error
      return null;
    }
  }

  @override
  Future<bool> savePokemon(Pokemon pokemon) {
    return _prefs.setString(pokemon.id.toString(), json.encode(pokemon.toJson()));
  }

  @override
  Future<bool> updateFavorites(List<PokemonId> ids) async {
    return await _prefs.setStringList(favoritesKey, ids.map((e) => e.toString()).toList());
  }

  @override
  List<PokemonId> getFavorites() {
    try {
      final ids = (_prefs.getStringList(favoritesKey)) ?? [];
      final pokemonIds = <PokemonId>[];

      for (final idString in ids) {
        final id = int.tryParse(idString);
        if (id != null) {
          pokemonIds.add(id);
        }
      }

      return pokemonIds;
    } catch (_) {
      // TODO log error
      return <PokemonId>[];
    }
  }
}
