import 'package:auto_route/auto_route.dart';
import 'package:character_list_page/src/ui/home_page.dart';
import 'package:character_list_page/src/ui/detailed_character_screen.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

import '../../character_list_page.dart';

part 'characters_router.gr.dart';

@AutoRouterConfig()
class CharactersRouter extends RootStackRouter {

  @override
  List<AutoRoute> get routes => <AutoRoute>[];
}