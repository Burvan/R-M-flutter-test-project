abstract class SettingsRepository {
  Future<bool> checkTheme();
  Future<void> setTheme(bool isDark);
}