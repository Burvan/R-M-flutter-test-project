import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: AppColors.gentlyGreen,
      shadowColor: AppColors.lightGreen,
      focusColor: AppColors.limeGreen,
      secondaryHeaderColor: AppColors.grey,
      brightness: Brightness.light,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.yellowGreen,
        titleTextStyle: AppTextTheme.font22BlackGetSchwiftyBold,
      ),
      cardTheme: CardTheme(
        color: AppColors.white,
        shadowColor: AppColors.limeGreen,
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            color: AppColors.lightGreen,
            width: AppSize.size2,
          ),
          borderRadius: BorderRadius.circular(AppBorderRadius.borderRadius12),
        ),
      ),
      switchTheme: const SwitchThemeData(
        trackColor: WidgetStatePropertyAll(AppColors.white),
        thumbColor: WidgetStatePropertyAll(AppColors.lightGreen),
        trackOutlineColor: WidgetStatePropertyAll(AppColors.lightGreen),
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.lightGreen,
        circularTrackColor: AppColors.white,
      ),
      textTheme: TextTheme(
        titleLarge: AppTextTheme.font20.copyWith(
          color: AppColors.black,
        ),
        titleMedium: AppTextTheme.font17.copyWith(
          color: AppColors.grey,
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      primaryColor: AppColors.darkGrey,
      shadowColor: AppColors.white,
      focusColor: AppColors.lightGrey,
      secondaryHeaderColor: AppColors.lightGrey,
      brightness: Brightness.dark,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.transparent,
        titleTextStyle: AppTextTheme.font22WhiteGetSchwiftyBold,
      ),
      cardTheme: CardTheme(
        color: AppColors.lightGrey,
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            color: AppColors.white,
            width: AppSize.size2,
          ),
          borderRadius: BorderRadius.circular(AppBorderRadius.borderRadius12),
        ),
      ),
      switchTheme: const SwitchThemeData(
        trackColor: WidgetStatePropertyAll(AppColors.lightGreen),
        thumbColor: WidgetStatePropertyAll(AppColors.white),
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.lightGreen,
        circularTrackColor: AppColors.white,
      ),
      textTheme: TextTheme(
        titleLarge: AppTextTheme.font20.copyWith(
          color: AppColors.white,
        ),
        titleMedium: AppTextTheme.font17.copyWith(
          color: AppColors.lightGrey,
        ),
      ),
    );
  }
}
