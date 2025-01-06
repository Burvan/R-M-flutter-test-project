import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:data/entities/character/character_entity.dart';
import 'package:data/entities/character/location_entity.dart';

HiveBoxes hiveBoxes = HiveBoxes();

class HiveBoxes{
  Future<void> openBoxes() async {
    await Hive.openBox<CharacterEntity>(AppStrings.charactersBoxName);
    await Hive.openBox<LocationEntity>(AppStrings.locationBoxName);
    await Hive.openBox<String>(AppStrings.themeBoxName);
  }
}