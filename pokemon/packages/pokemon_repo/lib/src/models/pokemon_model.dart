import 'pokemon_stat.dart';

typedef PokemonId = int;

class Pokemon {
  final PokemonId id;
  final String name;
  final List<String> types;
  final String imageUrl;
  final List<PokemonStat> stats;
  final int height;
  final int weight;
  final double bmi;
  final double avgPower;

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

  factory Pokemon({
    required PokemonId id,
    required String imageUrl,
    required String name,
    required List<String> types,
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

  factory Pokemon.fromJson(Map<String, dynamic> json) => Pokemon(
        id: json['id'],
        imageUrl: json['imageUrl'],
        name: json['name'],
        types: json['types'],
        stats: (json['stats'] as List).map((e) => PokemonStat.fromJson(e)).toList(),
        height: json['height'],
        weight: json['weight'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'types': types,
        'imageUrl': imageUrl,
        'stats': stats.map((e) => e.toJson()).toList(),
        'height': height,
        'weight': weight,
      };
}
