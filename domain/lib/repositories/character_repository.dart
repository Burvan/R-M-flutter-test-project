import 'package:domain/domain.dart';

abstract class CharacterRepository {
  Future<Result> fetchCharacters(Query query);
  Future<void> clearCache();
  Future<void> saveCharactersToCache(List<Character> characters);
  Future<List<Character>> getCharactersFromCache();
}