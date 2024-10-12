import 'dart:developer';

class PokemonCard {
  final String name;
  final String imageUrl;
  final String set;
  final List<String>? types;
  final List<Weakness>? weaknesses;
  final String artist;

  PokemonCard({
    required this.name,
    required this.imageUrl,
    required this.set,
    this.types,
    this.weaknesses,
    required this.artist,
  });

  factory PokemonCard.fromJson(Map<String, dynamic> json) {
    log("${json['name']}");
    return PokemonCard(
      name: json['name'],
      imageUrl: json['images']['large'],
      set: json['set']['name'],
      types: List<String>.from(json['types'] ?? []),
      weaknesses: (json['weaknesses'] as List?)
          ?.map((e) => Weakness.fromJson(e))
          .toList(),
      artist: json['artist'] ?? "",
    );
  }
}

class Weakness {
  final String type;

  Weakness({required this.type});

  factory Weakness.fromJson(Map<String, dynamic> json) {
    return Weakness(
      type: json['type'],
    );
  }
}
