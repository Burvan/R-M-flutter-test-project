import 'package:core/core.dart';
import 'package:data/entities/character/location_entity.dart';

part 'character_entity.g.dart';

@HiveType(typeId: 1)
class CharacterEntity {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String status;

  @HiveField(3)
  final String species;

  @HiveField(4)

  @HiveField(5)
  final String type;

  @HiveField(6)
  final String gender;

  @HiveField(7)
  final LocationEntity origin;

  @HiveField(8)
  final LocationEntity location;

  @HiveField(9)
  final String image;

  @HiveField(10)
  final List<String> episode;

  @HiveField(11)
  final String url;

  @HiveField(12)
  final String created;

  CharacterEntity({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.origin,
    required this.location,
    required this.image,
    required this.episode,
    required this.url,
    required this.created,
  });

  factory CharacterEntity.fromJson(Map<String, dynamic> json) {
    return CharacterEntity(
      id: json['id'] as int,
      name: json['name'] as String,
      status: json['status'] as String,
      species: json['species'] as String,
      type: json['type'] as String,
      gender: json['gender'] as String,
      origin: LocationEntity.fromJson(json['origin'] as Map<String, dynamic>),
      location:
          LocationEntity.fromJson(json['location'] as Map<String, dynamic>),
      image: json['image'] as String,
      episode: List<String>.from(json['episode']),
      url: json['url'] as String,
      created: json['created'] as String,
    );
  }
}
