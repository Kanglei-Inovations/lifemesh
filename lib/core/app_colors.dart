import 'package:flutter/material.dart';

class AppColors {
  static const Color deepNavy = Color(0xFF050816);
  static const Color neonPurple = Color(0xFF7C4DFF);
  static const Color cyanBlue = Color(0xFF00E5FF);
  static const Color softGlowPink = Color(0xFFFF4FD8);
  static const Color white = Colors.white;
  static const Color glassWhite = Color(0x1AFFFFFF);

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [neonPurple, cyanBlue],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient backgroundGradient = LinearGradient(
    colors: [deepNavy, Color(0xFF0A0F2D)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
