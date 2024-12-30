import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:navigation/navigation.dart';
import 'package:settings_page/settings_page.dart';

@RoutePage()
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SettingsBloc bloc = BlocProvider.of<SettingsBloc>(context);

    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (_, SettingsState state) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(AppPadding.padding10),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppPadding.padding16,
                  vertical: AppPadding.padding10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Text(
                      AppStrings.darkTheme,
                      style: AppTextTheme.font20Bold,
                    ),
                    Switch(
                      value: state.isDark,
                      onChanged: (bool value) {
                        bloc.add(
                          SetThemeEvent(isDark: value),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
