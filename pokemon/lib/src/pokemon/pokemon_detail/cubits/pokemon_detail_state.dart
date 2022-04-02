part of 'pokemon_detail_cubit.dart';

enum StateStatus {
  loading,
  success,
  notFound,
  requestFailed,
  unknownError,
}

class PokemonDetailState {
  final StateStatus status;
  final Pokemon? pokemon;

  const PokemonDetailState({
    required this.status,
    required this.pokemon,
  });
}
