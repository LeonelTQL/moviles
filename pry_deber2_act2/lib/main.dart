import 'package:flutter/material.dart';
import 'controller/nomina_controller.dart';
import 'view/menu_view.dart';
import 'view/registro_chofer_view.dart';
import 'view/reporte_nomina_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final NominaController sharedController = NominaController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nomina de Choferes',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      initialRoute: '/menu',
      routes: {
        '/menu': (context) => MenuView(controller: sharedController),
        '/registroNomina': (context) => RegistroChoferView(controller: sharedController),
        '/reporteNomina': (context) => ReporteNominaView(controller: sharedController),
      },
    );
  }
}
