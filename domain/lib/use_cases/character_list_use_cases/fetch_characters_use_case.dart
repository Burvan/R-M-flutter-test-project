import 'package:domain/domain.dart';

class FetchCharactersUseCase extends FutureUseCase<Result, Query> {
  final CharacterRepository _characterRepository;

  FetchCharactersUseCase({
    required CharacterRepository characterRepository,
  }) : _characterRepository = characterRepository;

  @override
  Future<Result> execute(Query input) async {
    return await _characterRepository.fetchCharacters(
      Query(
        page: input.page,
        queryParams: input.queryParams,
      ),
    );
  }
}
