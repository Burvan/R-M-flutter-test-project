import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:navigation/navigation.dart';
import 'package:settings_page/settings_page.dart';

import '../../character_list_page.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: const <PageRouteInfo>[
        CharacterListRoute(),
        SettingsRoute(),
      ],
      appBarBuilder: (_, TabsRouter tabsRouter) {
        return AppBar(
          backgroundColor: AppColors.yellowGreen,
          title: const Text(
            AppStrings.rmCharacters,
            style: AppTextTheme.font22BlackGetSchwiftyBold,
          ),
          centerTitle: true,
        );
      },
      bottomNavigationBuilder: (_, TabsRouter tabsRouter){
        return AppBottomNavigationBar(
          selectedIndex: tabsRouter.activeIndex,
          onTabChange: tabsRouter.setActiveIndex,
        );
      },
    );
  }
}
