import 'dart:convert';

import 'package:pokemon_api/src/interfaces/cache_interface.dart';
import 'package:pokemon_api/src/models/pokemon_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesCacheHandler implements PokemonLocalStorageHandler {
  final SharedPreferences _prefs;

  const SharedPreferencesCacheHandler({required SharedPreferences prefs}) : _prefs = prefs;

  @override
  Future<Map<String, dynamic>?>? readPokemon(int id) {
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
}
