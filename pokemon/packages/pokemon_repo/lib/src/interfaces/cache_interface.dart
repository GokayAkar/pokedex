import 'package:pokemon_api/src/models/pokemon_model.dart';

abstract class PokemonLocalStorageHandler {
  Future<bool> savePokemon(Pokemon pokemon);
  Future<Map<String, dynamic>?>? readPokemon(int id);
}
