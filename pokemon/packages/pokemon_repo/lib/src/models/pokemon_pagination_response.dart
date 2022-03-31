import 'pokemon_model.dart';

class PokemonPaginationResponse {
  final bool isLast;
  final List<PriorPokemonInfo> pokemons;

  const PokemonPaginationResponse({
    required this.isLast,
    required this.pokemons,
  });
}

class PriorPokemonInfo {
  final String name;
  final PokemonId id;

  const PriorPokemonInfo({
    required this.name,
    required this.id,
  });
}
