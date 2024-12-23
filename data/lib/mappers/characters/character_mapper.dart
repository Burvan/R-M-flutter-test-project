part of '../mappers.dart';

class CharacterMapper extends Mapper<CharacterEntity, domain.Character> {
  final LocationMapper _locationMapper;

  CharacterMapper({
    required LocationMapper locationMapper,
  }) : _locationMapper = locationMapper;

  @override
  domain.Character fromEntity(CharacterEntity entity) {
    return domain.Character(
      id: entity.id,
      name: entity.name,
      status: entity.status,
      species: entity.species,
      type: entity.type,
      gender: entity.gender,
      origin: _locationMapper.fromEntity(entity.origin),
      location: _locationMapper.fromEntity(entity.location),
      image: entity.image,
      episode: entity.episode,
      url: entity.url,
      created: entity.created,
    );
  }

  @override
  CharacterEntity toEntity(domain.Character item) {
    return CharacterEntity(
      id: item.id,
      name: item.name,
      status: item.status,
      species: item.species,
      type: item.type,
      gender: item.gender,
      origin: _locationMapper.toEntity(item.origin),
      location: _locationMapper.toEntity(item.location),
      image: item.image,
      episode: item.episode,
      url: item.url,
      created: item.created,
    );
  }
}
