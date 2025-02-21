import 'package:core/core.dart';
import 'package:core/errors/errors.dart';
import 'package:data/entities/character/character_entity.dart';
import 'package:data/entities/character/location_entity.dart';
import 'package:data/mappers/mappers.dart';
import 'package:domain/domain.dart';
import 'package:data/data.dart';

final DataDI dataDI = DataDI();

class DataDI {
  Future<void> setupAppLocator() async {
    appLocator.registerLazySingleton<MapperFactory>(
      () => MapperFactory(),
    );

    appLocator.registerLazySingleton<DioErrorHandler>(
          () => DioErrorHandler(),
    );

    appLocator.registerLazySingleton<InternetConnectionService>(
          () => InternetConnectionService(),
    );

    ///Adapters
    appLocator.registerLazySingleton<CharacterEntityAdapter>(
          () => CharacterEntityAdapter(),
    );

    appLocator.registerLazySingleton<LocationEntityAdapter>(
          () => LocationEntityAdapter(),
    );

    ///Hive
    await Hive.initFlutter();
    Hive.registerAdapter(
      appLocator.get<CharacterEntityAdapter>(),
    );
    Hive.registerAdapter(
      appLocator.get<LocationEntityAdapter>(),
    );

    ///Providers
    appLocator.registerLazySingleton<ApiProvider>(
      () => ApiProvider(
        mapper: appLocator.get<MapperFactory>(),
        errorHandler: appLocator.get<DioErrorHandler>(),
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
        hiveProvider: appLocator.get<HiveProvider>(),
        mapper: appLocator.get<MapperFactory>(),
        internetConnectionService: appLocator.get<InternetConnectionService>(),
      ),
    );

    appLocator.registerLazySingleton<SettingsRepository>(
      () => SettingsRepositoryImpl(
        hiveProvider: appLocator.get<HiveProvider>(),
      ),
    );
  }
}
