import 'pokemon_stat.dart';

class Pokemon {
  final int id;
  final String name;
  final List<String> types;
  final String imageUrl;
  final List<PokemonStat> stats;

  const Pokemon({
    required this.id,
    required this.imageUrl,
    required this.name,
    required this.types,
    required this.stats,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) => Pokemon(
        id: json['id'],
        imageUrl: json['imageUrl'],
        name: json['name'],
        types: json['types'],
        stats: (json['stats'] as List).map((e) => PokemonStat.fromJson(e)).toList(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'types': types,
        'imageUrl': imageUrl,
        'stats': stats.map((e) => e.toJson()).toList(),
      };
}
