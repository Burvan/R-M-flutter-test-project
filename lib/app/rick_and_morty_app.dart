import 'package:character_list_page/character_list_page.dart';
import 'package:flutter/material.dart';

class RickAndMortyApp extends StatelessWidget {
  const RickAndMortyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: CharacterListScreen(),
    );
  }
}
