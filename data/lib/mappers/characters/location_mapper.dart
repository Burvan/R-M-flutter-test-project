part of '../mappers.dart';

class LocationMapper extends Mapper<LocationEntity, domain.Location> {
  @override
  domain.Location fromEntity(LocationEntity entity) {
    return domain.Location(
      name: entity.name,
      url: entity.url,
    );
  }

  @override
  LocationEntity toEntity(domain.Location item) {
    return LocationEntity(
      name: item.name,
      url: item.url,
    );
  }
}
