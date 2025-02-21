import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:data/entities/character/character_entity.dart';
import 'package:data/entities/character/location_entity.dart';

class HiveProvider {
  ///Characters
  Future<void> saveCharactersToCache(List<CharacterEntity> characters) async {
    final Box<CharacterEntity> charactersBox = await Hive.openBox<CharacterEntity>(AppStrings.charactersBoxName);
    final Map<int, CharacterEntity> characterMap = {
      for (var character in characters) character.id: character
    };
    await charactersBox.putAll(characterMap);
    await charactersBox.close();
  }

  Future<List<CharacterEntity>> getCharactersFromCache() async {
    final Box<CharacterEntity> charactersBox = await Hive.openBox<CharacterEntity>(AppStrings.charactersBoxName);
    final List<CharacterEntity> characters = charactersBox.values.toList();
    await charactersBox.close();
    return characters;
  }

  Future<void> clearCachedCharacters() async {
    final Box<CharacterEntity> charactersBox = await Hive.openBox<CharacterEntity>(AppStrings.charactersBoxName);
    await charactersBox.clear();
    await charactersBox.close();
  }

  Future<bool> isCharactersBoxEmpty() async {
    final Box<CharacterEntity> charactersBox = await Hive.openBox<CharacterEntity>(AppStrings.charactersBoxName);
    final bool isBoxEmpty = charactersBox.isEmpty;
    await charactersBox.close();
    return isBoxEmpty;
  }

  ///Settings
  Future<bool> getTheme() async {
    final Box<String> themeBox = await Hive.openBox<String>(AppStrings.themeBoxName);
    final bool isDark = themeBox.get('isDark').toString() == 'true' ? true : false;
    await themeBox.close();
    return isDark;
  }

  Future<void> setTheme(bool isDark) async {
    final Box<String> themeBox = await Hive.openBox<String>(AppStrings.themeBoxName);
    await themeBox.put('isDark', isDark.toString());
    await themeBox.close();
  }
}
