import 'package:core/core.dart';
import 'package:data/entities/character/character_entity.dart';
import 'package:data/entities/character/location_entity.dart';

class HiveProvider {
  final Box<CharacterEntity> charactersBox;
  final Box<LocationEntity> locationBox;
  final Box<String> themeBox;

  HiveProvider({
    required this.charactersBox,
    required this.locationBox,
    required this.themeBox,
  });

  ///Characters
  Future<void> saveCharactersToCache(List<CharacterEntity> characters) async {
    final Map<int, CharacterEntity> characterMap = {
      for (var character in characters) character.id: character
    };
    await charactersBox.putAll(characterMap);
  }

  Future<List<CharacterEntity>> getCharactersFromCache() async {
    final List<CharacterEntity> characters = charactersBox.values.toList();
    return characters;
  }

  Future<void> clearCachedCharacters() async {
    await charactersBox.clear();
  }

  Future<bool> isCharactersBoxEmpty() async {
    return charactersBox.isEmpty;
  }

  ///Settings
  Future<bool> getTheme() async {
    return themeBox.get('isDark').toString() == 'true' ? true : false;
  }

  Future<void> setTheme(bool isDark) async {
    return themeBox.put('isDark', isDark.toString());
  }
}
