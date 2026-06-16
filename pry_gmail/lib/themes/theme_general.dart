import 'package:flutter/material.dart';

import 'esquema_color.dart';
import 'tema_botones.dart';
import 'tema_fondos.dart';
import 'tema_formulario.dart';
import 'temas_appbar.dart';
import 'tipografia.dart';

class ThemeGeneral {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: TemaFondos.colorScheme,
      scaffoldBackgroundColor: EsquemaColor.fondo,
      textTheme: TipografiaApp.textTheme,
      appBarTheme: TemasAppbar.appBarTheme,
      elevatedButtonTheme: TemaBotones.elevatedButtonTheme,
      floatingActionButtonTheme: TemaBotones.floatingActionButtonTheme,
      inputDecorationTheme: TemaFormulario.inputDecorationTheme,
      cardTheme: CardThemeData(
        color: EsquemaColor.tarjeta,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28),
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: EsquemaColor.borde,
        thickness: 1,
      ),
    );
  }
}
