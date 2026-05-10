import 'package:flutter/material.dart';
import 'persona_view.dart';
import 'perfecto_page.dart';
import 'bisiesto_view.dart';
import 'caja_view.dart';
import 'vuelto_view.dart';
class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ejercicios Tarea 1'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildExerciseButton(context, 'Ejercicio 1',  'Caja de Supermercado', CajaPage()),
          _buildExerciseButton(context, 'Ejercicio 2', 'Cálculo de Vuelto', VueltoPage()),
          _buildExerciseButton(context, 'Ejercicio 3','Año Bisiesto',BisiestoPagina()),
          _buildExerciseButton(context, 'Ejercicio 4', 'Cálculo de Números Perfectos', perfectoPage()),
          _buildExerciseButton(context, 'Ejercicio 5','Control de Peso - Club', ClubPage()) ,
        ],
      ),
    );
  }


  Widget _buildExerciseButton(BuildContext context, String title, String subtitle, Widget? page) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {
          if (page != null) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => page),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Este ejercicio está ToDo')),
            );
          }
        },
      ),
    );
  }
}
