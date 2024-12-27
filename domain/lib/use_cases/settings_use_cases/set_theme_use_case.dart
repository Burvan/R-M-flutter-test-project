import 'package:domain/domain.dart';

class SetThemeUseCase extends FutureUseCase<void, bool> {
  final SettingsRepository _settingsRepository;

  SetThemeUseCase({
    required SettingsRepository settingsRepository,
  }) : _settingsRepository = settingsRepository;

  @override
  Future<void> execute(bool isDark) {
    return _settingsRepository.setTheme(isDark);
  }
}
