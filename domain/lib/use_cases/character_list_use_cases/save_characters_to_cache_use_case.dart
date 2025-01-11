import 'package:domain/domain.dart';

class SaveCharactersToCacheUseCase
    extends FutureUseCase<void, List<Character>> {
  final CharacterRepository _characterRepository;

  SaveCharactersToCacheUseCase(
      {required CharacterRepository characterRepository})
      : _characterRepository = characterRepository;
  @override
  Future<void> execute(List<Character> input) async {
    await _characterRepository.saveCharactersToCache(input);
  }
}
