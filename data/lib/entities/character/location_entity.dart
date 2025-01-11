import 'package:core/core.dart';

part 'location_entity.g.dart';

@HiveType(typeId: 2)
class LocationEntity {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String url;

  LocationEntity({
    required this.name,
    required this.url,
  });

  factory LocationEntity.fromJson(Map<String, dynamic> json) {
    return LocationEntity(
      name: json['name'] as String,
      url: json['url'] as String,
    );
  }
}
