import 'package:core/core.dart';
import 'package:data/data.dart';
import 'package:data/entities/api/result_entity.dart';
import 'package:data/entities/character/character_entity.dart';
import 'package:data/mappers/mappers.dart';
import 'package:domain/domain.dart';

class CharacterRepositoryImpl implements CharacterRepository {
  final ApiProvider _apiProvider;
  final HiveProvider _hiveProvider;
  final InternetConnectionService _internetConnectionService;
  final MapperFactory mapper;
  bool _isCacheCleared = false;

  CharacterRepositoryImpl({
    required ApiProvider apiProvider,
    required HiveProvider hiveProvider,
    required InternetConnectionService internetConnectionService,
    required this.mapper,
  })  : _apiProvider = apiProvider,
        _hiveProvider = hiveProvider,
        _internetConnectionService = internetConnectionService;

  @override
  Future<Result> fetchCharacters(Query query) async {
    final bool isInternetConnection =
        await _internetConnectionService.isInternetConnection();

    if (isInternetConnection) {
      if (!_isCacheCleared) {
        await _hiveProvider.clearCachedCharacters();
        _isCacheCleared = true;
      }

      final ResultEntity responseEntity =
          await _apiProvider.fetchCharacters(query);

      await _hiveProvider.saveCharactersToCache(responseEntity.characters);

      return Result(
        characters: responseEntity.characters
            .map((CharacterEntity entity) =>
                mapper.characterMapper.fromEntity(entity))
            .toList(),
        info: mapper.infoMapper.fromEntity(responseEntity.info),
      );
    } else {
      final List<CharacterEntity> characters =
          await _hiveProvider.getCharactersFromCache();
      return Result(
        characters: characters
            .map((CharacterEntity entity) =>
                mapper.characterMapper.fromEntity(entity))
            .toList(),
        info: Info(count: 0, pages: 0, next: null, prev: null),
      );
    }
  }
}
