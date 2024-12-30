import 'package:core/core.dart';

class HiveProvider {
  ///Settings
  Future<bool> getTheme() async {
    final Box themeBox = await Hive.openBox('theme');
    return themeBox.get('isDark').toString() == 'true' ? true : false;
  }

  Future<void> setTheme(bool isDark) async {
    final Box themeBox = await Hive.openBox('theme');
    return themeBox.put('isDark', isDark.toString());
  }
}