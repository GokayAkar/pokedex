import 'package:equatable/equatable.dart';

class PokemonStat extends Equatable {
  final int value;
  final String name;

  const PokemonStat({
    required this.name,
    required this.value,
  });

  factory PokemonStat.fromJson(Map<String, dynamic> json) => PokemonStat(
        name: json['name'],
        value: json['value'],
      );

  Map<String, dynamic> toJson() => {
        'value': value,
        'name': name,
      };

  @override
  List<Object?> get props => [name, value];
}
