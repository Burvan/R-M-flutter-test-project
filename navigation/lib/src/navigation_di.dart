import 'package:core/di/app_di.dart';
import '../navigation.dart';

void setupNavigationDependencies() {
  appLocator.registerSingleton<AppRouter>(AppRouter());
}