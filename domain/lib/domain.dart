library domain;

///Models
export 'models/character/character.dart';
export 'models/character/location.dart';
export 'models/api/query.dart';
export 'models/api/result.dart';
export 'models/api/info.dart';
///Repositories
export 'repositories/character_repository.dart';
export 'repositories/settings_repository.dart';
/// UseCases
export 'use_cases/use_case.dart';
export 'use_cases/character_list_use_cases/fetch_characters_use_case.dart';
export 'use_cases/settings_use_cases/check_theme_use_case.dart';
export 'use_cases/settings_use_cases/set_theme_use_case.dart';