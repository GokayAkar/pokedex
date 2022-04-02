import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class PokemonType extends Equatable {
  final String name;

  Color get color;

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
  Color get color => Colors.blue;

  const UnknownType({
    required String name,
  }) : super(name: name);
}

class Fire extends PokemonType {
  const Fire() : super(name: 'Fire');

  @override
  Color get color => Colors.blue;
}

class Water extends PokemonType {
  const Water() : super(name: 'Water');

  @override
  Color get color => Colors.blue;
}

class Grass extends PokemonType {
  const Grass() : super(name: 'Grass');

  @override
  Color get color => Colors.blue;
}

class Poison extends PokemonType {
  const Poison() : super(name: 'Poison');

  @override
  Color get color => Colors.blue;
}

class Flying extends PokemonType {
  const Flying() : super(name: 'Flying');

  @override
  Color get color => Colors.blue;
}

class Bug extends PokemonType {
  const Bug() : super(name: 'Bug');

  @override
  Color get color => Colors.blue;
}

class Normal extends PokemonType {
  const Normal() : super(name: 'Normal');

  @override
  Color get color => Colors.blue;
}

class Electric extends PokemonType {
  const Electric() : super(name: 'Electric');

  @override
  Color get color => Colors.blue;
}

class Ground extends PokemonType {
  const Ground() : super(name: 'Ground');

  @override
  Color get color => Colors.blue;
}

class Fairy extends PokemonType {
  const Fairy() : super(name: 'Fairy');

  @override
  Color get color => Colors.blue;
}

class Fighting extends PokemonType {
  const Fighting() : super(name: 'Fighting');

  @override
  Color get color => Colors.blue;
}

class Psychic extends PokemonType {
  const Psychic() : super(name: 'Psychic');

  @override
  Color get color => Colors.blue;
}

class Rock extends PokemonType {
  const Rock() : super(name: 'Rock');

  @override
  Color get color => Colors.blue;
}

class Steel extends PokemonType {
  const Steel() : super(name: 'Steel');

  @override
  Color get color => Colors.blue;
}

class Ice extends PokemonType {
  const Ice() : super(name: 'Ice');

  @override
  Color get color => Colors.blue;
}
