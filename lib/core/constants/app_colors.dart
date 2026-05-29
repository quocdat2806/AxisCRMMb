import 'package:flutter/material.dart';

abstract final class AppColors {
  static const Color pink = Color(0xFFFF2D8B);
  static const Color pinkLight = Color(0xFFFF6EB4);
  static const Color purple = Color(0xFF9B27AF);
  static const Color purpleDeep = Color(0xFF6A0080);
  static const Color black = Color(0xFF0A0A0F);
  static const Color blackSoft = Color(0xFF1A1A2E);
  static const Color blackSoft2 = Color(0xFF0D0D1A);
  static const Color appBarStart = Color(0xFF1A0A2E);
  static const Color pinkShadow = Color(0x33FF2D8B);

  static const Color cardBackground = Color(0xFF16213E);
  static const Color cardBackgroundLight = Color(0xFF1F2B4A);

  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFB0B3C6);
  static const Color textHint = Color(0xFF6B6F8A);

  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFFF5252);
  static const Color warning = Color(0xFFFFD740);

  static const Color gold = Color(0xFFFFD740);
  static const Color orange = Color(0xFFFF8C00);

  static const LinearGradient mainGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [blackSoft, purpleDeep, black],
  );

  static const LinearGradient accentGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [pink, purple, purpleDeep],
  );

  static const LinearGradient cardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [cardBackground, cardBackgroundLight],
  );

  static const LinearGradient vipGradient = LinearGradient(
    colors: [gold, orange],
  );
  static LinearGradient ageGradient = LinearGradient(
    colors: [pink.withAlpha(30), purple.withAlpha(30)],
  );
}
