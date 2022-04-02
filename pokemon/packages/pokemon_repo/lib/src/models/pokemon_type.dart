import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class PokemonType extends Equatable {
  final String name;

  String get hexCode;

  const PokemonType({
    required this.name,
  });

  factory PokemonType.fromString({required String name}) {
    switch (name) {
      case 'Fire':
        return const Fire();
      case 'Water':
        return const Water();
      case 'Poison':
        return const Poison();
      case 'Grass':
        return const Grass();
      case 'Flying':
        return const Flying();
      case 'Bug':
        return const Bug();
      case 'Normal':
        return const Normal();
      case 'Electric':
        return const Electric();
      case 'Ground':
        return const Ground();
      case 'Fairy':
        return const Fairy();
      case 'Fighting':
        return const Fighting();
      case 'Psychic':
        return const Psychic();
      case 'Rock':
        return const Rock();
      case 'Steel':
        return const Steel();
      case 'Ice':
        return const Ice();
      default:
        return UnknownType(name: name);
    }
  }

  @override
  List<Object?> get props => [name];
}

class UnknownType extends PokemonType {
  @override
  String get hexCode => '68A090';

  const UnknownType({
    required String name,
  }) : super(name: name);
}

class Fire extends PokemonType {
  const Fire() : super(name: 'Fire');

  @override
  String get hexCode => 'F08030';
}

class Water extends PokemonType {
  const Water() : super(name: 'Water');

  @override
  String get hexCode => '6890F0';
}

class Grass extends PokemonType {
  const Grass() : super(name: 'Grass');

  @override
  String get hexCode => '78C850';
}

class Poison extends PokemonType {
  const Poison() : super(name: 'Poison');

  @override
  String get hexCode => 'A040A0';
}

class Flying extends PokemonType {
  const Flying() : super(name: 'Flying');

  @override
  String get hexCode => 'A890F0';
}

class Bug extends PokemonType {
  const Bug() : super(name: 'Bug');

  @override
  String get hexCode => 'A8B820';
}

class Normal extends PokemonType {
  const Normal() : super(name: 'Normal');

  @override
  String get hexCode => 'A8A878';
}

class Electric extends PokemonType {
  const Electric() : super(name: 'Electric');

  @override
  String get hexCode => 'F8D030';
}

class Ground extends PokemonType {
  const Ground() : super(name: 'Ground');

  @override
  String get hexCode => 'E0C068';
}

class Fairy extends PokemonType {
  const Fairy() : super(name: 'Fairy');

  @override
  String get hexCode => 'EE99AC';
}

class Fighting extends PokemonType {
  const Fighting() : super(name: 'Fighting');

  @override
  String get hexCode => 'C03028';
}

class Psychic extends PokemonType {
  const Psychic() : super(name: 'Psychic');

  @override
  String get hexCode => 'F85888';
}

class Rock extends PokemonType {
  const Rock() : super(name: 'Rock');

  @override
  String get hexCode => 'B8A038';
}

class Steel extends PokemonType {
  const Steel() : super(name: 'Steel');

  @override
  String get hexCode => 'B8B8D0';
}

class Ice extends PokemonType {
  const Ice() : super(name: 'Ice');

  @override
  String get hexCode => '98D8D8';
}
