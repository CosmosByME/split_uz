import 'package:flutter/material.dart';

class AppColors {
  // Backgrounds
  static const background = Color(0xFF0D0D1A);
  static const surface = Color(0xFF1A1A2E);
  static const surfaceElevated = Color(0xFF22223A);
  static const border = Color(0x14FFFFFF);

  // Semantic
  static const danger = Color(0xFFFF6B6B);
  static const success = Color(0xFF00E5A0);
  static const warning = Color(0xFFFFB547);
  static const neutral = Color(0xFF8888AA);

  // Primary
  static const primary = Color(0xFF6C63FF);
  static const primaryPressed = Color(0xFF5A52E0);
  static const primaryGlow = Color(0x336C63FF);

  // Typography
  static const textPrimary = Color(0xFFFFFFFF);
  static const textSecondary = Color(0xAAFFFFFF);
  static const textCaption = Color(0x66FFFFFF);
  static const textDisabled = Color(0x33FFFFFF);
}

final appColorScheme = ColorScheme(
  brightness: Brightness.dark,

  // Primary
  primary: AppColors.primary,
  onPrimary: AppColors.textPrimary,
  primaryContainer: AppColors.primaryGlow,
  onPrimaryContainer: AppColors.primary,

  // Secondary — mapped to success (money owed to you)
  secondary: AppColors.success,
  onSecondary: AppColors.background,
  secondaryContainer: Color(0x2000E5A0),
  onSecondaryContainer: AppColors.success,

  // Tertiary — mapped to warning (pending state)
  tertiary: AppColors.warning,
  onTertiary: AppColors.background,
  tertiaryContainer: Color(0x20FFB547),
  onTertiaryContainer: AppColors.warning,

  // Error — mapped to danger (you owe)
  error: AppColors.danger,
  onError: AppColors.background,
  errorContainer: Color(0x20FF6B6B),
  onErrorContainer: AppColors.danger,

  // Surfaces
  surface: AppColors.surface,
  onSurface: AppColors.textPrimary,
  surfaceContainerHighest: AppColors.surfaceElevated,
  onSurfaceVariant: AppColors.textSecondary,

  // Outline
  outline: AppColors.border,
  outlineVariant: AppColors.border,

  // Background
  // ignore: deprecated_member_use
  background: AppColors.background,
  // ignore: deprecated_member_use
  onBackground: AppColors.textPrimary,

  // Shadow and scrim
  shadow: Colors.black,
  scrim: Colors.black,

  // Inverse — for snackbars etc
  inverseSurface: AppColors.textPrimary,
  onInverseSurface: AppColors.background,
  inversePrimary: AppColors.primaryPressed,
);