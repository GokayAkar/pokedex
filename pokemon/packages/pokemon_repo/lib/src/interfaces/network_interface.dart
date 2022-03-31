import '../models/models.dart';

abstract class PokemonHttpHandler {
  Future<Map<String, dynamic>> fetchPokemonDetail(PokemonId id);
  Future<Map<String, dynamic>> fetchPokemons({required int limit, required int offset});
}
