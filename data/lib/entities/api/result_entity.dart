import 'package:data/entities/api/info_entity.dart';
import 'package:data/entities/character/character_entity.dart';

class ResultEntity {
  final List<CharacterEntity> characters;
  final InfoEntity info;

  ResultEntity({
    required this.characters,
    required this.info,
  });
}