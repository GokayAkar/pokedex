import 'dart:ui';

abstract class PokemonType {
  final String name;

  Color get color;

  const PokemonType({
    required this.name,
  });

  factory PokemonType.fromString({required String name}) {
    switch (name) {
      case 'fire':
        return const Fire();
      case 'water':
        return const Water();
      case 'poison':
        return const Poison();
      case 'grass':
        return const Grass();
      case 'flying':
        return const Flying();
      default:
        return UnknownType(name: name);
    }
  }
}

class UnknownType extends PokemonType {
  @override
  // TODO: implement color
  Color get color => throw UnimplementedError();

  const UnknownType({
    required String name,
  }) : super(name: name);
}

class Fire extends PokemonType {
  const Fire() : super(name: 'fire');

  @override
  // TODO: implement color
  Color get color => throw UnimplementedError();
}

class Water extends PokemonType {
  const Water() : super(name: 'water');

  @override
  // TODO: implement color
  Color get color => throw UnimplementedError();
}

class Grass extends PokemonType {
  const Grass() : super(name: 'grass');

  @override
  // TODO: implement color
  Color get color => throw UnimplementedError();
}

class Poison extends PokemonType {
  const Poison() : super(name: 'poison');

  @override
  // TODO: implement color
  Color get color => throw UnimplementedError();
}

class Flying extends PokemonType {
  const Flying() : super(name: 'flying');

  @override
  // TODO: implement color
  Color get color => throw UnimplementedError();
}
