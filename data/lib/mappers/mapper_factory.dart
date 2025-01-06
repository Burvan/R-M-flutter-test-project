part of 'mappers.dart';

class MapperFactory {
  LocationMapper get locationMapper => LocationMapper();
  CharacterMapper get characterMapper => CharacterMapper(locationMapper: locationMapper);
  InfoMapper get infoMapper => InfoMapper();
}