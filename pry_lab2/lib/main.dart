import 'package:flutter/material.dart';
import 'themes/teme_general.dart';
import 'views/splash_view.dart';
import 'views/vista_menu_ejercicios.dart';
import 'views/registro_venta_view.dart';
import 'views/vista_salario_profesor.dart';
import 'views/hamburguesa_view.dart';
import 'views/vista_cantidades.dart';
import 'views/registro_promocion_view.dart';
import 'views/resultado_view.dart';
import 'views/reporte_promocion_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Laboratorio 2 - Aplicación Uniforme',
      theme: TemeGeneral.claro,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashView(),
        '/menu': (context) => const VistaMenuEjercicios(),
        '/ventas': (context) => RegistroVentaView(),
        '/profesor': (context) => const VistaSalarioProfesor(),
        '/hamburguesas': (context) => const HamburguesaView(),
        '/cantidades': (context) => const VistaCantidades(),
        '/articulos': (context) => RegistroPromocionView(),
        '/resultado_ventas': (context) => ResultadoView(),
        '/reporte_articulos': (context) => ReportePromocionView(),
      },
    );
  }
}