import 'package:core/internet_connection/internet_connection.dart';
import 'package:data/data.dart';
import 'package:data/entities/api/result_entity.dart';
import 'package:data/entities/character/character_entity.dart';
import 'package:data/mappers/mappers.dart';
import 'package:domain/domain.dart';

class CharacterRepositoryImpl implements CharacterRepository {
  final ApiProvider _apiProvider;
  final HiveProvider _hiveProvider;
  final MapperFactory mapper;

  CharacterRepositoryImpl({
    required ApiProvider apiProvider,
    required HiveProvider hiveProvider,
    required this.mapper,
  })  : _apiProvider = apiProvider,
        _hiveProvider = hiveProvider;

  @override
  Future<Result> fetchCharacters(Query query) async {
    final ResultEntity responseEntity =
    await _apiProvider.fetchCharacters(query);

    return Result(
      characters: responseEntity.characters
          .map((CharacterEntity entity) =>
          mapper.characterMapper.fromEntity(entity))
          .toList(),
      info: mapper.infoMapper.fromEntity(responseEntity.info),
    );
  }

  @override
  Future<void> clearCache() async {
      final bool isCacheEmpty = await _hiveProvider.isCharactersBoxEmpty();

      if (!isCacheEmpty) {
        await _hiveProvider.clearCachedCharacters();
      }
  }

  @override
  Future<List<Character>> getCharactersFromCache() async {
    final List<CharacterEntity> entityCharacters =
        await _hiveProvider.getCharactersFromCache();

    return entityCharacters
        .map((CharacterEntity entity) =>
            mapper.characterMapper.fromEntity(entity))
        .toList();
  }

  @override
  Future<void> saveCharactersToCache(List<Character> characters) async {
    final List<CharacterEntity> entityCharacters = characters
        .map(
            (Character character) => mapper.characterMapper.toEntity(character))
        .toList();

    await _hiveProvider.saveCharactersToCache(entityCharacters);
  }
}
