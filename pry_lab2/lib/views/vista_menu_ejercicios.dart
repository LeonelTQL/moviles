import 'package:flutter/material.dart';
import '../widgets/atomos/boton_principal_app.dart';
import '../widgets/moleculas/encabezado_ejercicio.dart';

class VistaMenuEjercicios extends StatelessWidget {
  const VistaMenuEjercicios({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menú de Ejercicios'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const EncabezadoEjercicio(
                titulo: 'Laboratorio 2',
                descripcion:
                    'Seleccione uno de los ejercicios realizados en clase para visualizar su funcionamiento.',
              ),
              const SizedBox(height: 20),
              BotonPrincipalApp(
                texto: 'Ejercicio 1: Ventas',
                icono: Icons.shopping_cart,
                onPressed: () => Navigator.pushNamed(context, '/ventas'),
              ),
              const SizedBox(height: 12),
              BotonPrincipalApp(
                texto: 'Ejercicio 2: Profesor',
                icono: Icons.school,
                onPressed: () => Navigator.pushNamed(context, '/profesor'),
              ),
              const SizedBox(height: 12),
              BotonPrincipalApp(
                texto: 'Ejercicio 3: Hamburguesas',
                icono: Icons.fastfood,
                onPressed: () => Navigator.pushNamed(context, '/hamburguesas'),
              ),
              const SizedBox(height: 12),
              BotonPrincipalApp(
                texto: 'Ejercicio 4: Cantidades',
                icono: Icons.calculate,
                onPressed: () => Navigator.pushNamed(context, '/cantidades'),
              ),
              const SizedBox(height: 12),
              BotonPrincipalApp(
                texto: 'Ejercicio 5: Artículos',
                icono: Icons.inventory_2,
                onPressed: () => Navigator.pushNamed(context, '/articulos'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

