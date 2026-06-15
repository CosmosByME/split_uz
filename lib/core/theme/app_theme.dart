import 'package:flutter/material.dart';
import 'package:split_uz/core/theme/app_colors.dart';
import 'package:split_uz/core/theme/typography.dart';

final appTheme = ThemeData(
  brightness: Brightness.dark,
  useMaterial3: true,
  colorScheme: appColorScheme,
  scaffoldBackgroundColor: AppColors.background,
  textTheme: TextTheme(
    displayLarge: AppTypography.displayLarge,
    displayMedium: AppTypography.displayMedium,
    titleLarge: AppTypography.titleLarge,
    titleMedium: AppTypography.titleMedium,
    bodyLarge: AppTypography.bodyLarge,
    bodyMedium: AppTypography.bodyMedium,
    labelLarge: AppTypography.label,
    bodySmall: AppTypography.caption,
  ),
);