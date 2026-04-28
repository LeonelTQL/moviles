import 'package:flutter/material.dart';
import '../controller/persona_controller.dart';

/// =====================
/// 1. ÁTOMOS
/// =====================

class Label extends StatelessWidget {
  final String text;

  Label(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }
}

class NumberField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;

  NumberField({
    super.key,
    required this.controller,
    required this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: hint,
        border: OutlineInputBorder(),
      ),
    );
  }
}

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(text),
    );
  }
}

/// =====================
/// 2. MOLÉCULA (10 inputs)
/// =====================

class TenInput extends StatelessWidget {
  final List<TextEditingController> controllers;

  TenInput({super.key, required this.controllers});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(10, (i) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: NumberField(
            controller: controllers[i],
            hint: "Peso ${i + 1}",
          ),
        );
      }),
    );
  }
}

/// =====================
/// 3. ORGANISMO (1 persona)
/// =====================

class PersonaCard extends StatefulWidget {
  final String titulo;

  PersonaCard({super.key, required this.titulo});

  @override
  State<PersonaCard> createState() => _PersonaCardState();
}

class _PersonaCardState extends State<PersonaCard> {

  final _controllers = List.generate(10, (_) => TextEditingController());
  final _controller = PersonaController();

  String _resultado = "";

  void _calcular() {
    setState(() {
      _resultado = _controller.procesar(
        _controllers.map((c) => c.text).toList(),
      );
    });
  }

  @override
  void dispose() {
    for (var c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            Label(widget.titulo),
            SizedBox(height: 10),

            TenInput(controllers: _controllers),

            SizedBox(height: 10),

            PrimaryButton(
              text: "Calcular",
              onPressed: _calcular,
            ),

            SizedBox(height: 10),

            Text(_resultado),
          ],
        ),
      ),
    );
  }
}

/// =====================
/// 4. PÁGINA PRINCIPAL
/// =====================

class ClubPage extends StatelessWidget {
  ClubPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Control de Peso - Club"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            PersonaCard(titulo: "Persona 1"),
            PersonaCard(titulo: "Persona 2"),
            PersonaCard(titulo: "Persona 3"),
            PersonaCard(titulo: "Persona 4"),
            PersonaCard(titulo: "Persona 5"),
          ],
        ),
      ),
    );
  }
}