import 'dart:ui';

import 'package:equatable/equatable.dart';

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
  Color get color => const Color(0xff68A090);

  const UnknownType({
    required String name,
  }) : super(name: name);
}

class Fire extends PokemonType {
  const Fire() : super(name: 'Fire');

  @override
  Color get color => const Color(0xffF08030);
}

class Water extends PokemonType {
  const Water() : super(name: 'Water');

  @override
  Color get color => const Color(0xff6890F0);
}

class Grass extends PokemonType {
  const Grass() : super(name: 'Grass');

  @override
  Color get color => const Color(0xff78C850);
}

class Poison extends PokemonType {
  const Poison() : super(name: 'Poison');

  @override
  Color get color => const Color(0xffA040A0);
}

class Flying extends PokemonType {
  const Flying() : super(name: 'Flying');

  @override
  Color get color => const Color(0xffA890F0);
}

class Bug extends PokemonType {
  const Bug() : super(name: 'Bug');

  @override
  Color get color => const Color(0xffA8B820);
}

class Normal extends PokemonType {
  const Normal() : super(name: 'Normal');

  @override
  Color get color => const Color(0xffA8A878);
}

class Electric extends PokemonType {
  const Electric() : super(name: 'Electric');

  @override
  Color get color => const Color(0xffF8D030);
}

class Ground extends PokemonType {
  const Ground() : super(name: 'Ground');

  @override
  Color get color => const Color(0xffE0C068);
}

class Fairy extends PokemonType {
  const Fairy() : super(name: 'Fairy');

  @override
  Color get color => const Color(0xffEE99AC);
}

class Fighting extends PokemonType {
  const Fighting() : super(name: 'Fighting');

  @override
  Color get color => const Color(0xffC03028);
}

class Psychic extends PokemonType {
  const Psychic() : super(name: 'Psychic');

  @override
  Color get color => const Color(0xffF85888);
}

class Rock extends PokemonType {
  const Rock() : super(name: 'Rock');

  @override
  Color get color => const Color(0xffB8A038);
}

class Steel extends PokemonType {
  const Steel() : super(name: 'Steel');

  @override
  Color get color => const Color(0xffB8B8D0);
}

class Ice extends PokemonType {
  const Ice() : super(name: 'Ice');

  @override
  Color get color => const Color(0xff98D8D8);
}
