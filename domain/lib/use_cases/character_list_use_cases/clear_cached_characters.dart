import 'package:domain/domain.dart';

class ClearCachedCharactersUseCase extends FutureUseCase<void, NoParams> {
  final CharacterRepository _characterRepository;

  ClearCachedCharactersUseCase({
    required CharacterRepository characterRepository,
  }) : _characterRepository = characterRepository;

  @override
  Future<void> execute(NoParams input) async {
    await _characterRepository.clearCache();
  }
}
