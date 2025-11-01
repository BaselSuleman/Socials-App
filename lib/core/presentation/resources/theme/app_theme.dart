import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_color_scheme.dart';
import 'package:easy_localization/easy_localization.dart';

class AppTheme {
  final AppColorScheme appColorScheme;

  AppTheme(this.appColorScheme);

  ThemeData getThemeData(BuildContext context) {
    final isArabic = context.locale.languageCode == 'ar';
    final fontFamily = isArabic ? GoogleFonts.cairo().fontFamily : GoogleFonts.poppins().fontFamily;
    final textTheme = _buildTextTheme(isArabic, fontFamily!);

    return ThemeData(
      fontFamily: fontFamily,
      cardTheme: CardThemeData(color: appColorScheme.cardBackgroundColor),
      brightness: Theme.of(context).brightness,
      primaryColor: appColorScheme.primaryColor,
      primarySwatch: _generateMaterialColor(),
      scaffoldBackgroundColor: appColorScheme.backgroundColor,
      cardColor: appColorScheme.cardBackgroundColor,
      canvasColor: appColorScheme.backgroundAccentColor,
      hintColor: appColorScheme.placeholderColor,
      disabledColor: appColorScheme.placeholderColor,
      dividerColor: appColorScheme.dividerColor,
      popupMenuTheme: const PopupMenuThemeData(color: Colors.white),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: appColorScheme.backgroundColor,
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: appColorScheme.accentColor,
      ),
      iconTheme: IconThemeData(color: appColorScheme.iconTintColor),
      appBarTheme: AppBarTheme(
        backgroundColor: appColorScheme.appBarBackgroundColor,
        elevation: 1,
        surfaceTintColor: appColorScheme.appBarBackgroundColor,
        iconTheme: IconThemeData(color: appColorScheme.appBarIconColor),
        titleTextStyle: TextStyle(
          color: appColorScheme.primaryFontColor,
          fontSize: 18.sp,
        ),
      ),
      textTheme: textTheme.apply(
        bodyColor: appColorScheme.primaryFontColor,
        displayColor: appColorScheme.primaryFontColor,
      ),
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: TextStyle(color: appColorScheme.secondaryFontColor),
        hintStyle: TextStyle(color: appColorScheme.placeholderColor),
        fillColor: appColorScheme.cardBackgroundColor,
        filled: true,
        contentPadding: const EdgeInsets.symmetric(vertical: 7, horizontal: 14),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: appColorScheme.inputBorderColor),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          padding: WidgetStateProperty.all(
            EdgeInsets.symmetric(vertical: 10.h, horizontal: 8.w),
          ),
          overlayColor: WidgetStateProperty.all(Colors.grey.shade300),
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.disabled)) return Colors.grey.shade300;
            return appColorScheme.buttonBackgroundColor;
          }),
          foregroundColor: WidgetStateProperty.all(appColorScheme.elevatedButtonTextColor),
          shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          padding: WidgetStateProperty.all(
            EdgeInsets.symmetric(vertical: 17.h, horizontal: 16.w),
          ),
          overlayColor: WidgetStateProperty.all(appColorScheme.primaryColor.withAlpha(50)),
          backgroundColor: WidgetStateProperty.all(appColorScheme.backgroundColor),
          foregroundColor: WidgetStateProperty.all(appColorScheme.outlineButtonTextColor),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(27),
              side: BorderSide(color: appColorScheme.primaryColor),
            ),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: WidgetStateProperty.all(appColorScheme.primaryColor),
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: appColorScheme.backgroundColor,
        selectedItemColor: appColorScheme.primaryColor,
        unselectedItemColor: appColorScheme.iconTintColor,
        selectedLabelStyle: TextStyle(fontSize: 10.sp),
        unselectedLabelStyle: TextStyle(fontSize: 9.sp),
      ),
      dialogTheme: DialogThemeData(backgroundColor: appColorScheme.cardBackgroundColor),
    );
  }

  TextTheme _buildTextTheme(bool isArabic, String fontFamily) {
    return TextTheme(
      displayLarge: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w600, fontFamily: fontFamily),
      displayMedium: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600, fontFamily: fontFamily),
      displaySmall: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600, fontFamily: fontFamily),
      headlineMedium: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600, fontFamily: fontFamily),
      headlineSmall: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w600, fontFamily: fontFamily),
      titleLarge: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600, fontFamily: fontFamily),
      titleMedium: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500, fontFamily: fontFamily),
      titleSmall: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500, fontFamily: fontFamily),
      bodyLarge: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, fontFamily: fontFamily),
      bodyMedium: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400, fontFamily: fontFamily),
      bodySmall: TextStyle(fontSize: 12.sp, fontFamily: fontFamily),
      labelSmall: TextStyle(fontSize: 10.sp, fontFamily: fontFamily),
      labelMedium: TextStyle(fontSize: 12.sp, fontFamily: fontFamily),
      labelLarge: TextStyle(fontSize: 16.sp, fontFamily: fontFamily),
    );
  }

  MaterialColor _generateMaterialColor() {
    final color = appColorScheme.primaryColor;
    return MaterialColor(color.value, {
      50: _tintColor(color, 0.9),
      100: _tintColor(color, 0.8),
      200: _tintColor(color, 0.6),
      300: _tintColor(color, 0.4),
      400: _tintColor(color, 0.2),
      500: color,
      600: _shadeColor(color, 0.1),
      700: _shadeColor(color, 0.2),
      800: _shadeColor(color, 0.3),
      900: _shadeColor(color, 0.4),
    });
  }

  Color _tintColor(Color color, double factor) => Color.fromRGBO(
    _tintValue(color.red, factor),
    _tintValue(color.green, factor),
    _tintValue(color.blue, factor),
    1,
  );

  int _tintValue(int value, double factor) => (value + ((255 - value) * factor)).round().clamp(0, 255);

  Color _shadeColor(Color color, double factor) => Color.fromRGBO(
    _shadeValue(color.red, factor),
    _shadeValue(color.green, factor),
    _shadeValue(color.blue, factor),
    1,
  );

  int _shadeValue(int value, double factor) => (value - (value * factor)).round().clamp(0, 255);
}
