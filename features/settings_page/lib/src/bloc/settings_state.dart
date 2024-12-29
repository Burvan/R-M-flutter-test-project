part of 'settings_bloc.dart';

class SettingsState extends Equatable {
  final ThemeData themeData;
  final bool isDark;

  SettingsState({
    required this.themeData,
    required this.isDark,
  });

  SettingsState copyWith({
    ThemeData? themeData,
    bool? isDark,
  }) {
    return SettingsState(
      themeData: themeData ?? this.themeData,
      isDark: isDark ?? this.isDark,
    );
  }

  @override
  List<Object?> get props => [
        themeData,
        isDark,
      ];
}
