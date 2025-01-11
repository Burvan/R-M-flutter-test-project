import 'package:domain/domain.dart';

class GetCharactersFromCacheUseCase
    extends FutureUseCase<List<Character>, NoParams> {
  final CharacterRepository _characterRepository;

  GetCharactersFromCacheUseCase(
      {required CharacterRepository characterRepository})
      : _characterRepository = characterRepository;

  @override
  Future<List<Character>> execute(NoParams input) {
    return _characterRepository.getCharactersFromCache();
  }
}
