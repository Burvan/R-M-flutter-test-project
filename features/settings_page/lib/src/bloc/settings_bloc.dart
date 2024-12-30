import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:core/core.dart';
import 'package:domain/domain.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final CheckThemeUseCase _checkThemeUseCase;
  final SetThemeUseCase _setThemeUseCase;

  SettingsBloc({
    required CheckThemeUseCase checkThemeUseCase,
    required SetThemeUseCase setThemeUseCase,
  })  : _checkThemeUseCase = checkThemeUseCase,
        _setThemeUseCase = setThemeUseCase,
        super(SettingsState(themeData: AppTheme.lightTheme, isDark: false)) {
    on<InitSettingsEvent>(_onInitSettings);
    on<SetThemeEvent>(_onSetTheme);

    add(const InitSettingsEvent());
  }

  Future<void> _onInitSettings(
    InitSettingsEvent event,
    Emitter<SettingsState> emit,
  ) async {
    final bool isDark = await _checkThemeUseCase.execute(const NoParams());
    emit(
      state.copyWith(
        themeData: isDark ? AppTheme.darkTheme : AppTheme.lightTheme,
        isDark: isDark,
      ),
    );
  }

  Future<void> _onSetTheme(
    SetThemeEvent event,
    Emitter<SettingsState> emit,
  ) async {
    await _setThemeUseCase.execute(event.isDark);
    emit(
      state.copyWith(
        themeData: event.isDark ? AppTheme.darkTheme : AppTheme.lightTheme,
        isDark: event.isDark,
      ),
    );
  }
}
