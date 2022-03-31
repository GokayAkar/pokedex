import '../models/models.dart';

abstract class PokemonHttpHandler {
  Future<Map<String, dynamic>> fetchPokemonDetail(PokemonId id);
}
