import 'package:data/entities/character/character_entity.dart';
import 'package:data/mappers/mappers.dart';
import 'package:core/core.dart';

class ApiProvider {
  final MapperFactory mapper;

  ApiProvider({
    required this.mapper,
  });

  Future<List<CharacterEntity>> fetchCharacters({int page = 0}) async {
    try {
      final Response<Map<String, dynamic>> response = await Dio()
          .get('https://rickandmortyapi.com/api/character/?page=$page');

      if (response != null && response.statusCode == 200) {
        final Map<String, dynamic> data = response.data!;
        final List<dynamic> results = data['results'];
        return results
            .map((json) =>
                CharacterEntity.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        // Handle non-200 status codes
        print('API Error: Status code ${response?.statusCode}');
        return [];
      }
    } on DioException catch (e) {
      // Handle Dio-specific exceptions
      print('Dio Error: ${e.message}');
      return [];
    } catch (e) {
      // Handle other exceptions
      print('General Error: $e');
      return [];
    }
  }
}
