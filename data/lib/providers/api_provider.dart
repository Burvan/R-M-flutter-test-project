import 'package:core_ui/core_ui.dart';
import 'package:data/entities/api/info_entity.dart';
import 'package:data/entities/api/result_entity.dart';
import 'package:data/entities/character/character_entity.dart';
import 'package:data/mappers/mappers.dart';
import 'package:core/core.dart';
import 'package:domain/domain.dart';


class ApiProvider {
  final MapperFactory mapper;

  ApiProvider({
    required this.mapper,
  });

  Future<ResultEntity> fetchCharacters(Query query) async {
    try {
      const String baseUrl =
          AppStrings.baseUrl;
      final Map<String, String> params = <String, String>{};
      params['page'] = query.page.toString();

      if (query.queryParams != null) {
        query.queryParams!.forEach((key, value) {
          if(value != null){
            params[key] = value.toString();
          }
        });
      }

      final Uri uri = Uri.parse(baseUrl).replace(queryParameters: params);

      final Response<Map<String, dynamic>> response =
      await Dio().get(uri.toString());

      if (response != null && response.statusCode == 200) {
        final Map<String, dynamic> data = response.data!;
        final List<dynamic> results = data['results'];
        final InfoEntity info = InfoEntity.fromJson(data['info']);
        return ResultEntity(
            characters: results
                .map((json) =>
                CharacterEntity.fromJson(json as Map<String, dynamic>))
                .toList(),
            info: info,
        );
        } else {
        print('API Error: Status code ${response?.statusCode}');
        return ResultEntity(
          characters: [],
          info: InfoEntity(count: 0, pages: 0, next: null, prev: null),
        );
      }
    } on DioException catch (e) {
      print('Dio Error: ${e.message}');
      return ResultEntity(
        characters: [],
        info: InfoEntity(count: 0, pages: 0, next: null, prev: null),
      );
    } catch (e) {
      print('General Error: $e');
      return ResultEntity(
        characters: [],
        info: InfoEntity(count: 0, pages: 0, next: null, prev: null),
      );
    }
  }
}
