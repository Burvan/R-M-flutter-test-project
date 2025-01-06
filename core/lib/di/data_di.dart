import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:data/entities/character/character_entity.dart';
import 'package:data/entities/character/location_entity.dart';
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
    appLocator.registerLazySingleton<Box<CharacterEntity>>(
          () => Hive.box<CharacterEntity>(AppStrings.charactersBoxName),
    );
    appLocator.registerLazySingleton<Box<LocationEntity>>(
          () => Hive.box<LocationEntity>(AppStrings.locationBoxName),
    );
    appLocator.registerLazySingleton<Box<String>>(
          () => Hive.box<String>(AppStrings.themeBoxName),
    );

    ///Providers
    appLocator.registerLazySingleton<ApiProvider>(
      () => ApiProvider(
        mapper: appLocator.get<MapperFactory>(),
      ),
    );

    appLocator.registerLazySingleton<HiveProvider>(
      () => HiveProvider(
        charactersBox: appLocator.get<Box<CharacterEntity>>(),
        locationBox: appLocator.get<Box<LocationEntity>>(),
        themeBox: appLocator.get<Box<String>>(),
      ),
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
