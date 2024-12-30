import 'package:flutter/material.dart';
import 'package:core_ui/src/theme/app_colors.dart';

class AppTextTheme {
  static const String _getSchwiftyFamily = 'GetSchwifty';

  static const TextStyle font20Bold = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle font17Grey = TextStyle(
    fontSize: 17,
    color: AppColors.grey,
  );

  static const TextStyle font17LightGrey = TextStyle(
    fontSize: 17,
    color: AppColors.grey,
  );

  static const TextStyle font20Grey = TextStyle(
    fontSize: 20,
    color: AppColors.lightGrey,
  );

  static const TextStyle font20Green = TextStyle(
    fontSize: 20,
    color: AppColors.yellowGreen,
  );

  static const TextStyle font20Red = TextStyle(
    fontSize: 20,
    color: AppColors.red,
  );

  static const TextStyle font20Black = TextStyle(
    fontSize: 20,
    color: AppColors.black,
  );

  static const TextStyle font20White = TextStyle(
    fontSize: 20,
    color: AppColors.white,
  );

  static const TextStyle font18BlackGetSchwiftyBold = TextStyle(
    fontSize: 18,
    fontFamily: _getSchwiftyFamily,
    fontWeight: FontWeight.bold,
    color: AppColors.black,
  );

  static const TextStyle font20BlackGetSchwiftyBold = TextStyle(
    fontSize: 20,
    fontFamily: _getSchwiftyFamily,
    fontWeight: FontWeight.bold,
    color: AppColors.black,
  );

  static const TextStyle font22BlackGetSchwiftyBold = TextStyle(
    fontSize: 22,
    fontFamily: _getSchwiftyFamily,
    fontWeight: FontWeight.bold,
    color: AppColors.black,
  );

  static const TextStyle font22WhiteGetSchwiftyBold = TextStyle(
    fontSize: 22,
    fontFamily: _getSchwiftyFamily,
    fontWeight: FontWeight.bold,
    color: AppColors.white,
  );

  static const TextStyle font17 = TextStyle(
    fontSize: 17,
  );

  static const TextStyle font20 = TextStyle(
    fontSize: 20,
  );
}