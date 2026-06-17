import 'package:flutter/material.dart';
import 'esquema_color.dart';
import 'temas_appbar.dart';
import 'tema_botones.dart';
import 'tema_formulario.dart';

class TemaGeneral {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: EsquemaColor.lightScheme,
      scaffoldBackgroundColor: EsquemaColor.fondo,
      appBarTheme: TemasAppBar.lightAppBarTheme,
      elevatedButtonTheme: TemaBotones.elevatedButtonTheme,
      inputDecorationTheme: TemaFormulario.inputDecorationTheme,
    );
  }
}
