import 'package:core/errors/errors.dart';
import 'package:core_ui/core_ui.dart';
import 'package:data/entities/api/info_entity.dart';
import 'package:data/entities/api/result_entity.dart';
import 'package:data/entities/character/character_entity.dart';
import 'package:data/mappers/mappers.dart';
import 'package:core/core.dart';
import 'package:domain/domain.dart';


class ApiProvider {
  final MapperFactory mapper;
  final DioErrorHandler _errorHandler;

  ApiProvider({
    required this.mapper,
    required DioErrorHandler errorHandler,
  }) : _errorHandler = errorHandler;

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
        throw ApiException(
          message: response.statusMessage ?? 'No message',
          statusCode: response.statusCode,
        );
      }
    } on DioException catch (e) {
      throw _errorHandler.handleDioError(e);
    } catch (e) {
      throw UnknownException(message: e.toString());
    }
  }
}
