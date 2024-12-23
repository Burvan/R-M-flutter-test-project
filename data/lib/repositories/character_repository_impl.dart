import 'package:data/data.dart';
import 'package:data/entities/character/character_entity.dart';
import 'package:data/mappers/mappers.dart';
import 'package:domain/domain.dart' as domain;

class CharacterRepositoryImpl implements domain.CharacterRepository {
  final ApiProvider _apiProvider;
  final MapperFactory mapper;

  CharacterRepositoryImpl({
    required ApiProvider apiProvider,
    required this.mapper,
  }) : _apiProvider = apiProvider;

  @override
  Future<List<domain.Character>> fetchCharacters({int page = 0}) async {
    final List<CharacterEntity> characters =
        await _apiProvider.fetchCharacters(page: page);
    return characters
        .map((CharacterEntity entity) =>
            mapper.characterMapper.fromEntity(entity))
        .toList();
  }
}
