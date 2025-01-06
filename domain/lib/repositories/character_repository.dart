import 'package:domain/domain.dart';

abstract class CharacterRepository {
  Future<Result> fetchCharacters(Query query);
}