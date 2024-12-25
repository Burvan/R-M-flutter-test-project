import 'package:auto_route/auto_route.dart';
import 'package:character_list_page/character_list_page.dart';
import 'package:settings_page/settings_page.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => <AutoRoute>[
    AutoRoute(
      page: HomeRoute.page,
      path: '/',
      children: <AutoRoute>[
        AutoRoute(page: CharacterListRoute.page, initial: true),
        AutoRoute(page: SettingsRoute.page),
      ],
    ),
    AutoRoute(
      page: DetailedCharacterRoute.page,
    ),
  ];
}


