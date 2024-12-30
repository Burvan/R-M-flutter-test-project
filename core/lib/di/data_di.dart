import 'package:core/core.dart';
import 'package:data/mappers/mappers.dart';
import 'package:domain/domain.dart';
import 'package:core/di/app_di.dart';
import 'package:data/data.dart';

final DataDI dataDI = DataDI();

class DataDI {
  Future<void> setupAppLocator() async {
    appLocator.registerLazySingleton<MapperFactory>(
      () => MapperFactory(),
    );

    await Hive.initFlutter();

    ///Providers
    appLocator.registerLazySingleton<ApiProvider>(
      () => ApiProvider(
        mapper: appLocator.get<MapperFactory>(),
      ),
    );

    appLocator.registerLazySingleton<HiveProvider>(
      () => HiveProvider(),
    );

    ///UseCases
    appLocator.registerLazySingleton<FetchCharactersUseCase>(
      () => FetchCharactersUseCase(
        characterRepository: appLocator.get<CharacterRepository>(),
      ),
    );

    appLocator.registerLazySingleton<CheckThemeUseCase>(
      () => CheckThemeUseCase(
        settingsRepository: appLocator.get<SettingsRepository>(),
      ),
    );

    appLocator.registerLazySingleton<SetThemeUseCase>(
      () => SetThemeUseCase(
        settingsRepository: appLocator.get<SettingsRepository>(),
      ),
    );

    ///Repositories
    appLocator.registerLazySingleton<CharacterRepository>(
      () => CharacterRepositoryImpl(
        apiProvider: appLocator.get<ApiProvider>(),
        mapper: appLocator.get<MapperFactory>(),
      ),
    );

    appLocator.registerLazySingleton<SettingsRepository>(
      () => SettingsRepositoryImpl(
        hiveProvider: appLocator.get<HiveProvider>(),
      ),
    );
  }
}
