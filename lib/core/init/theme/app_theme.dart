import 'package:flutter/material.dart';

import '../../constants/color_constants.dart';

@immutable
class AppTheme {
  const AppTheme._();

  static ThemeData get darkTheme {
    final base = ThemeData.dark();

    return base.copyWith(
      scaffoldBackgroundColor: ColorConstants.darkSpace,
      colorScheme: base.colorScheme.copyWith(
        primary: ColorConstants.crystalBlue,
        secondary: ColorConstants.mintGreen,
        error: ColorConstants.radicalRed,
        background: ColorConstants.darkSpace,
        surface: ColorConstants.darkSpace.withOpacity(0.9),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: ColorConstants.darkSpace,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: ColorConstants.white),
        titleTextStyle: const TextStyle(
          color: ColorConstants.white,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      cardColor: ColorConstants.darkSpace.withOpacity(0.6),
      useMaterial3: true,
      textTheme: base.textTheme.apply(
        bodyColor: ColorConstants.white,
        displayColor: ColorConstants.white,
      ),
    );
  }
}
