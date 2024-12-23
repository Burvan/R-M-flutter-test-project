class LocationEntity {
  final String name;
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
