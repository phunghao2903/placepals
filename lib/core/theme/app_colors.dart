import 'package:flutter/material.dart';

class AppColors {
  const AppColors._();

  // Legacy aliases for existing code.
  static const Color primary = BrandColors.primary500;
  static const Color primarySoft = BrandColors.primary50;

  static const Color background = SemanticSurfaceColors.background;
  static const Color surface = SemanticSurfaceColors.background;
  static const Color surfaceSoft = SemanticSurfaceColors.subtle;
  static const Color surfaceMuted = SemanticSurfaceColors.card;
  static const Color surfaceSubtle = SemanticSurfaceColors.elevated;
  static const Color iconBackground = NeutralColors.neutral300;

  static const Color textPrimary = SemanticTextColors.primary;
  static const Color textSecondary = SemanticTextColors.tertiary;
  static const Color border = SemanticBorderColors.defaultBorder;

  static const Color success = PrimitiveStateColors.success500;
  static const Color info = PrimitiveStateColors.info500;
  static const Color error = PrimitiveStateColors.error500;
  static const Color warning = PrimitiveStateColors.warning500;

  static const Color shadow = SemanticSurfaceColors.overlayDark20;
}

class BrandColors {
  const BrandColors._();

  static const Color primary50 = Color(0xFFFFF0EF);
  static const Color primary100 = Color(0xFFFFD1CC);
  static const Color primary200 = Color(0xFFFFBBB3);
  static const Color primary300 = Color(0xFFFF9C90);
  static const Color primary400 = Color(0xFFFF897B);
  static const Color primary500 = Color(0xFFFF6B5A);
  static const Color primary600 = Color(0xFFE86152);
  static const Color primary700 = Color(0xFFB54C40);
  static const Color primary800 = Color(0xFF8C3B32);
  static const Color primary900 = Color(0xFF6B2D26);
}

class NeutralColors {
  const NeutralColors._();

  static const Color neutral0 = Color(0xFFFFFFFF);
  static const Color neutral50 = Color(0xFFFCFAFA);
  static const Color neutral100 = Color(0xFFF4F1F0);
  static const Color neutral200 = Color(0xFFEFEAE9);
  static const Color neutral300 = Color(0xFFE8E0DF);
  static const Color neutral400 = Color(0xFFE3DAD9);
  static const Color neutral500 = Color(0xFFDCD1CF);
  static const Color neutral600 = Color(0xFFC8BEBC);
  static const Color neutral700 = Color(0xFF9C9493);
  static const Color neutral800 = Color(0xFF797372);
  static const Color neutral900 = Color(0xFF2D2D2D);
}

class PrimitiveStateColors {
  const PrimitiveStateColors._();

  static const Color success500 = Color(0xFF22C55E);
  static const Color info500 = Color(0xFF3B82F6);
  static const Color error500 = Color(0xFFEF4444);
  static const Color warning500 = Color(0xFFF59E0B);
}

class SemanticSurfaceColors {
  const SemanticSurfaceColors._();

  static const Color background = NeutralColors.neutral0;
  static const Color subtle = NeutralColors.neutral50;
  static const Color card = NeutralColors.neutral100;
  static const Color elevated = NeutralColors.neutral200;
  static const Color overlayDark = Color(0x662D2D2D);
  static const Color overlayLight = Color(0x66EFEAE9);
  static const Color overlayDark70 = Color(0xB22D2D2D);
  static const Color overlayDark20 = Color(0x332D2D2D);
}

class SemanticTextColors {
  const SemanticTextColors._();

  static const Color primary = NeutralColors.neutral900;
  static const Color secondary = NeutralColors.neutral600;
  static const Color tertiary = NeutralColors.neutral700;
  static const Color disabled = NeutralColors.neutral300;
  static const Color onBrand = NeutralColors.neutral0;
  static const Color brand = BrandColors.primary500;
}

class SemanticBorderColors {
  const SemanticBorderColors._();

  static const Color defaultBorder = NeutralColors.neutral300;
  static const Color strong = NeutralColors.neutral700;
}

class SemanticIconColors {
  const SemanticIconColors._();

  static const Color primary = NeutralColors.neutral900;
  static const Color secondary = NeutralColors.neutral600;
  static const Color tertiary = NeutralColors.neutral700;
  static const Color disabled = NeutralColors.neutral300;
  static const Color onBrand = NeutralColors.neutral0;
  static const Color brand = BrandColors.primary500;
}

class SemanticStateColors {
  const SemanticStateColors._();

  static const Color successBackground = PrimitiveStateColors.success500;
  static const Color successText = PrimitiveStateColors.success500;

  static const Color errorBackground = PrimitiveStateColors.error500;
  static const Color errorText = NeutralColors.neutral0;

  static const Color warningBackground = PrimitiveStateColors.warning500;
  static const Color warningText = NeutralColors.neutral0;

  static const Color infoBackground = PrimitiveStateColors.info500;
  static const Color infoOverlay = Color(0x333B82F6);
}

class AppSemanticColors {
  const AppSemanticColors._();

  static const Color primary = BrandColors.primary500;
  static const Color secondary = BrandColors.primary50;
}

class ComponentColors {
  const ComponentColors._();

  static const Color favoriteDefaultBackground =
      SemanticSurfaceColors.overlayDark;
  static const Color favoriteDefaultIcon = SemanticIconColors.onBrand;
  static const Color favoriteActiveBackground =
      SemanticSurfaceColors.overlayLight;
  static const Color favoriteActiveIcon = SemanticIconColors.brand;

  static const Color buttonPrimaryBackground = BrandColors.primary500;
  static const Color buttonPrimaryText = SemanticTextColors.onBrand;

  static const Color buttonSecondaryBackground = SemanticSurfaceColors.elevated;
  static const Color buttonSecondaryText = SemanticTextColors.primary;
  static const Color buttonSecondaryBorder = SemanticBorderColors.defaultBorder;

  static const Color buttonDisabledBackground = SemanticIconColors.tertiary;
  static const Color buttonDisabledText = SemanticTextColors.onBrand;

  static const Color chipBrandBackground = BrandColors.primary50;
  static const Color chipBrandText = BrandColors.primary500;
  static const Color chipBrandIcon = BrandColors.primary500;

  static const Color chipSelectedBackground = BrandColors.primary500;
  static const Color chipSelectedText = SemanticTextColors.onBrand;
  static const Color chipSelectedIcon = SemanticIconColors.onBrand;

  static const Color ratingActive = SemanticStateColors.warningBackground;
  static const Color ratingInactive = SemanticIconColors.disabled;

  static const Color tabInactiveText = SemanticTextColors.tertiary;
  static const Color tabInactiveIcon = SemanticIconColors.secondary;

  static const Color tabActiveText = BrandColors.primary500;
  static const Color tabActiveIcon = BrandColors.primary500;
}
