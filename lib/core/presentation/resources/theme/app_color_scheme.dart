import 'package:flutter/material.dart';

abstract class AppColorScheme {
  Color get primaryColor;

  Color get secondaryColor;

  Color get accentColor;

  Color get errorColor;

  Color get placeholderColor;

  Color get inputBorderColor;

  Color get dividerColor;

  Color get primaryFontColor;

  Color get primaryTabBarLabelColor;

  Color get secondaryFontColor;

  Color get cardBackgroundColor;

  Color get backgroundColor;

  Color get appBarBackgroundColor;

  Color get backgroundAccentColor;

  Color get iconTintColor;

  Color get buttonBackgroundColor;

  Color get elevatedButtonTextColor;

  Color get outlineButtonTextColor;

  Color get appBarIconColor;

  Color get fieldBackgroundColor;

  Color get secondaryCardBackgroundColor;

  Color get infoTextColor;
}

class AppDarkColorScheme extends AppColorScheme {
  @override
  Color get primaryColor => const Color(0xFF1274AA);

  @override
  Color get secondaryColor => const Color(0xFF5EC8E1);

  @override
  Color get accentColor => const Color(0xFF008B99);

  @override
  Color get errorColor => const Color(0xFFFF5959);

  @override
  Color get placeholderColor => const Color(0xFFC1C7D0);

  @override
  Color get inputBorderColor => const Color(0xFF1F2329);

  @override
  Color get dividerColor => const Color(0xFFF2F6F7);

  @override
  Color get primaryFontColor => const Color(0xFFFFFFFF);

  @override
  Color get primaryTabBarLabelColor => const Color(0xFF47B9C4);

  @override
  Color get secondaryFontColor => const Color(0xFFEFF3F5);

  @override
  Color get cardBackgroundColor => const Color(0xFF1F2329);

  @override
  Color get backgroundColor => const Color(0xFF333A42);

  @override
  Color get appBarBackgroundColor => const Color(0xFF333A42);

  @override
  Color get backgroundAccentColor => const Color(0xFF1F2329);

  @override
  Color get iconTintColor => const Color(0xFFFFFFFF);

  @override
  Color get buttonBackgroundColor => const Color(0xFF1274AA);

  @override
  Color get elevatedButtonTextColor => const Color(0xFFFFFFFF);

  @override
  Color get outlineButtonTextColor => const Color(0xFFFFFFFF);

  @override
  Color get appBarIconColor => const Color(0xFFFFFFFF);

  @override
  Color get fieldBackgroundColor => const Color(0xFF42526E);

  @override
  Color get secondaryCardBackgroundColor => const Color(0xFF333A42);

  @override
  Color get infoTextColor => const Color(0xFF979797);
}

class AppLightColorScheme extends AppColorScheme {
  @override
  Color get primaryColor => const Color(0xFF1274AA);

  @override
  Color get secondaryColor => const Color(0xFF5EC8E1);

  @override
  Color get accentColor => const Color(0xFF008B99);

  @override
  Color get errorColor => const Color(0xFFFF5959);

  @override
  Color get placeholderColor => const Color(0xFFC1C7D0);

  @override
  Color get inputBorderColor => const Color(0xFFC1C7D0);

  @override
  Color get dividerColor => Colors.grey;

  @override
  Color get primaryFontColor => const Color(0xFF000000);

  @override
  Color get primaryTabBarLabelColor => const Color(0xFF47B9C4);

  @override
  Color get secondaryFontColor => const Color(0xFF000000);

  @override
  Color get cardBackgroundColor => const Color(0xFFFFFFFF);

  @override
  Color get backgroundColor => const Color(0xFFFFFFFF);

  @override
  Color get appBarBackgroundColor => const Color(0xFFFFFFFF);

  @override
  Color get backgroundAccentColor => const Color(0xFFECF1FA);

  @override
  Color get iconTintColor => const Color(0xFF6E7183);

  @override
  Color get buttonBackgroundColor => const Color(0xFF1274AA);

  @override
  Color get elevatedButtonTextColor => const Color(0xFFFFFFFF);

  @override
  Color get outlineButtonTextColor => const Color(0xFF008B99);

  @override
  Color get appBarIconColor => const Color(0xFF000000);

  @override
  Color get fieldBackgroundColor => const Color(0xFF42526E);

  @override
  Color get secondaryCardBackgroundColor => const Color(0xFFEDEDED);

  @override
  Color get infoTextColor => const Color(0xFF979797);
}
