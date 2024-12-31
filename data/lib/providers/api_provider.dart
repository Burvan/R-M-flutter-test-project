import 'package:data/entities/character/character_entity.dart';
import 'package:data/mappers/mappers.dart';
import 'package:core/core.dart';

class ApiProvider {
  final MapperFactory mapper;

  ApiProvider({
    required this.mapper,
  });

  Future<List<CharacterEntity>> fetchCharacters({
    int page = 0,
    String? status,
    String? species,
  }) async {
    try {
      final String url =
          'https://rickandmortyapi.com/api/character/?page=$page';
      final Map<String, String> queryParams = <String, String>{};

      if (status != null && status.isNotEmpty) {
        queryParams['status'] = status;
      }

      if (species != null && species.isNotEmpty) {
        queryParams['species'] = species;
      }

      final Uri uri = Uri.parse(url).replace(queryParameters: queryParams);

      final Response<Map<String, dynamic>> response =
          await Dio().get(uri.toString());

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
