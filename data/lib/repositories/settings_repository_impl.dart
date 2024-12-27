import 'package:data/providers/hive_provider.dart';
import 'package:domain/domain.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final HiveProvider _hiveProvider;

  SettingsRepositoryImpl({
    required HiveProvider hiveProvider,
  }) : _hiveProvider = hiveProvider;

  @override
  Future<bool> checkTheme() {
    return _hiveProvider.getTheme();
  }

  @override
  Future<void> setTheme(bool isDark) {
    return _hiveProvider.setTheme(isDark);
  }
}
