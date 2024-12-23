import 'package:data/mappers/mappers.dart';
import 'package:data/repositories/character_repository_impl.dart';
import 'package:domain/domain.dart';
import 'package:core/di/app_di.dart';
import 'package:data/data.dart';
//import 'package:domain/repositories/characters_repository.dart';

final DataDI dataDI = DataDI();

class DataDI {
  Future<void> setupAppLocator() async {
    appLocator.registerLazySingleton<MapperFactory>(
      () => MapperFactory(),
    );

    ///Providers
    appLocator.registerLazySingleton<ApiProvider>(
      () => ApiProvider(
        mapper: appLocator.get<MapperFactory>(),
      ),
    );

    ///UseCases
    appLocator.registerLazySingleton(
      () => FetchCharactersUseCase(
        characterRepository: appLocator.get<CharacterRepository>(),
      ),
    );

    ///Repositories
    appLocator.registerLazySingleton<CharacterRepository>(
      () => CharacterRepositoryImpl(
        apiProvider: appLocator.get<ApiProvider>(),
        mapper: appLocator.get<MapperFactory>(),
      ),
    );
  }
}
