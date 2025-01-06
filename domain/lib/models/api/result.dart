import 'package:domain/models/api/info.dart';
import 'package:domain/models/character/character.dart';

class Result {
  final List<Character> characters;
  final Info info;

  Result({
    required this.characters,
    required this.info,
  });
}