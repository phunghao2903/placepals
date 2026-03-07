import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppTextStyles {
  // Heading styles (SemiBold)
  static TextStyle get heading1 => _heading(40);
  static TextStyle get heading2 => _heading(30);
  static TextStyle get heading3 => _heading(18);
  static TextStyle get heading4 => _heading(24);
  static TextStyle get heading5 => _heading(20);
  static TextStyle get heading6 => _heading(16);
  static TextStyle get heading7 => _heading(14);
  static TextStyle get heading8 => _heading(12);

  // Body styles (Regular)
  static TextStyle get body1 => _body(16);
  static TextStyle get body2 => _body(14);
  static TextStyle get caption => _body(12);

  static TextStyle _heading(double size) {
    return GoogleFonts.inter(
      fontSize: size,
      fontWeight: FontWeight.w600,
      color: AppColors.textPrimary,
    );
  }

  static TextStyle _body(double size) {
    return GoogleFonts.inter(
      fontSize: size,
      fontWeight: FontWeight.w400,
      color: AppColors.textSecondary,
    );
  }
}
