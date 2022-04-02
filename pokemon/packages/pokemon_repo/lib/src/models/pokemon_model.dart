import 'dart:ui';

import 'package:equatable/equatable.dart';

import 'pokemon_stat.dart';
import 'pokemon_type.dart';

typedef PokemonId = int;

class Pokemon extends Equatable {
  final PokemonId id;
  final String name;
  final String imageUrl;
  final int height;
  final int weight;
  final double bmi;
  final double avgPower;
  final List<PokemonType> types;
  final List<PokemonStat> stats;

  const Pokemon._({
    required this.id,
    required this.imageUrl,
    required this.name,
    required this.types,
    required this.stats,
    required this.height,
    required this.weight,
    required this.avgPower,
    required this.bmi,
  });

  Color get pokemonColor => types.first.color.withOpacity(0.3);
  String get typesString => types.map((e) => e.name).join(', ');

  factory Pokemon({
    required PokemonId id,
    required String imageUrl,
    required String name,
    required List<PokemonType> types,
    required List<PokemonStat> stats,
    required int height,
    required int weight,
  }) {
    final bmi = weight / (height * height);
    final avgPower = stats.fold<int>(0, (previousValue, element) => previousValue + element.value) / stats.length;
    return Pokemon._(
      id: id,
      imageUrl: imageUrl,
      name: name,
      types: types,
      stats: stats,
      height: height,
      weight: weight,
      avgPower: avgPower,
      bmi: bmi,
    );
  }

  factory Pokemon.fromJson(Map<String, dynamic> json) => Pokemon._(
        id: json['id'],
        imageUrl: json['imageUrl'],
        name: json['name'],
        types: (json['types'] as List).map((e) => PokemonType.fromString(name: e)).toList(),
        stats: (json['stats'] as List).map((e) => PokemonStat.fromJson(e)).toList(),
        height: json['height'],
        weight: json['weight'],
        avgPower: json['avgPower'].toDouble(),
        bmi: json['bmi'].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'types': types.map((e) => e.name).toList(),
        'imageUrl': imageUrl,
        'stats': stats.map((e) => e.toJson()).toList(),
        'height': height,
        'weight': weight,
        'avgPower': avgPower,
        'bmi': bmi,
      };

  @override
  List<Object?> get props => [id];
}
