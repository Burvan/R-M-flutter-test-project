import 'package:domain/models/character/character.dart';

abstract class CharacterRepository {
  Future<List<Character>> fetchCharacters({int page = 0});
}