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

  ///Settings
  Future<bool> getTheme() async {
    return themeBox.get('isDark').toString() == 'true' ? true : false;
  }

  Future<void> setTheme(bool isDark) async {
    return themeBox.put('isDark', isDark.toString());
  }
}
