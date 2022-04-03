part of 'pokemon_detail_cubit.dart';

enum PokemonDetailStateStatus {
  loading,
  success,
  notFound,
  requestFailed,
  unknownError,
}

class PokemonDetailState extends Equatable {
  final PokemonDetailStateStatus status;
  final Pokemon? pokemon;

  const PokemonDetailState({
    required this.status,
    required this.pokemon,
  });

  @override
  List<Object?> get props => [
        status,
        pokemon,
      ];
}
