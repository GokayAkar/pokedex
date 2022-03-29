class Pokemon {
  final int id;
  final String name;
  final List<String> types;
  final String imageUrl;

  const Pokemon({
    required this.id,
    required this.imageUrl,
    required this.name,
    required this.types,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) => Pokemon(
        id: json['id'],
        imageUrl: json['imageUrl'],
        name: json['name'],
        types: json['types'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'types': types,
        'imageUrl': imageUrl,
      };
}
