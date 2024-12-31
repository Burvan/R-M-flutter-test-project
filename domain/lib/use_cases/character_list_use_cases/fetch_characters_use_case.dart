import 'package:domain/domain.dart';

class FetchCharactersUseCase
    extends FutureUseCase<List<Character>, FetchCharactersInput> {
  final CharacterRepository _characterRepository;

  FetchCharactersUseCase({
    required CharacterRepository characterRepository,
  }) : _characterRepository = characterRepository;

  @override
  Future<List<Character>> execute(FetchCharactersInput input) {
    return _characterRepository.fetchCharacters(
      page: input.page,
      status: input.status,
      species: input.species,
    );
  }
}

class FetchCharactersInput {
  final int page;
  final String? status;
  final String? species;

  FetchCharactersInput({
    required this.page,
    this.status,
    this.species,
  });
}
