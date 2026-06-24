import 'package:flutter/material.dart';
import 'esquema_color.dart';

class ThemeGeneral {
  static ThemeData get lightTheme => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: EsquemaColor.primary,
          primary: EsquemaColor.primary,
          secondary: EsquemaColor.purple,
          surface: EsquemaColor.surface,
        ),
        scaffoldBackgroundColor: EsquemaColor.background,
        fontFamily: 'Roboto',
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 0,
          backgroundColor: EsquemaColor.surface,
          foregroundColor: EsquemaColor.dark,
          surfaceTintColor: Colors.transparent,
          titleTextStyle: TextStyle(
            color: EsquemaColor.dark,
            fontWeight: FontWeight.w800,
            fontSize: 20,
          ),
        ),
        cardTheme: CardThemeData(
          color: EsquemaColor.surface,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: EsquemaColor.primary,
            foregroundColor: Colors.white,
            elevation: 0,
            minimumSize: const Size.fromHeight(54),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
            textStyle: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: EsquemaColor.dark,
            side: const BorderSide(color: EsquemaColor.line),
            minimumSize: const Size.fromHeight(48),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(18), borderSide: BorderSide.none),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(18), borderSide: BorderSide.none),
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(18), borderSide: const BorderSide(color: EsquemaColor.primary, width: 1.4)),
          filled: true,
          fillColor: EsquemaColor.chip,
          contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedItemColor: EsquemaColor.dark,
          unselectedItemColor: EsquemaColor.dark,
          selectedLabelStyle: TextStyle(fontWeight: FontWeight.w800),
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          elevation: 14,
        ),
      );
}
