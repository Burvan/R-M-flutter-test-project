import 'package:data/data.dart';
import 'package:data/entities/api/result_entity.dart';
import 'package:data/entities/character/character_entity.dart';
import 'package:data/mappers/mappers.dart';
import 'package:domain/domain.dart';

class CharacterRepositoryImpl implements CharacterRepository {
  final ApiProvider _apiProvider;
  final MapperFactory mapper;


  CharacterRepositoryImpl({
    required ApiProvider apiProvider,
    required this.mapper,
  }) : _apiProvider = apiProvider;

  @override
  Future<Result> fetchCharacters(Query query) async {
    final ResultEntity responseEntity = await _apiProvider.fetchCharacters(query);
    return Result(
        characters: responseEntity.characters
            .map((CharacterEntity entity) =>
            mapper.characterMapper.fromEntity(entity))
            .toList(),
        info: mapper.infoMapper.fromEntity(responseEntity.info),
    );
  }
}