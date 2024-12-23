import 'package:domain/domain.dart';

class FetchCharactersUseCase extends FutureUseCase<List<Character>, int> {
  final CharacterRepository _characterRepository;

  FetchCharactersUseCase({
    required CharacterRepository characterRepository,
  }) : _characterRepository = characterRepository;

  @override
  Future<List<Character>> execute(int input) {
    return _characterRepository.fetchCharacters(page: input);
  }
}