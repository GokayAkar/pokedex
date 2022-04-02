part of 'pokemon_detail_cubit.dart';

enum PokemonDetailStateStatus {
  loading,
  success,
  notFound,
  requestFailed,
  unknownError,
}

class PokemonDetailState {
  final PokemonDetailStateStatus status;
  final Pokemon? pokemon;

  const PokemonDetailState({
    required this.status,
    required this.pokemon,
  });
}
