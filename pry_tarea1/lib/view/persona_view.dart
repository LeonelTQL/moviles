import 'package:flutter/material.dart';
import '../controller/persona_controller.dart';

/// =====================
/// 1. ÁTOMOS
/// =====================

class Label extends StatelessWidget {
  final String text;

  const Label(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }
}

class NumberField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;

  const NumberField({
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
        prefixIcon: const Icon(Icons.monitor_weight_outlined),
        border: const OutlineInputBorder(),
      ),
    );
  }
}

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: const Icon(Icons.calculate),
      label: Text(text),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      ),
    );
  }
}

/// =====================
/// 2. MOLÉCULA (10 inputs)
/// =====================

class TenInput extends StatelessWidget {
  final List<TextEditingController> controllers;

  const TenInput({super.key, required this.controllers});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2.5,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: 10,
      itemBuilder: (context, i) {
        return NumberField(
          controller: controllers[i],
          hint: "Peso ${i + 1}",
        );
      },
    );
  }
}

/// =====================
/// 3. ORGANISMO (1 persona)
/// =====================

class PersonaCard extends StatefulWidget {
  final String titulo;

  const PersonaCard({super.key, required this.titulo});

  @override
  State<PersonaCard> createState() => _PersonaCardState();
}

class _PersonaCardState extends State<PersonaCard> with AutomaticKeepAliveClientMixin {
  final _controllers = List.generate(10, (_) => TextEditingController());
  final _controller = PersonaController();
  String _resultado = "";

  @override
  bool get wantKeepAlive => true;

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
    super.build(context);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Label(widget.titulo),
          const SizedBox(height: 20),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TenInput(controllers: _controllers),
                  const SizedBox(height: 20),
                  PrimaryButton(
                    text: "Calcular Resultados",
                    onPressed: _calcular,
                  ),
                  const SizedBox(height: 20),
                  if (_resultado.isNotEmpty)
                    Card(
                      color: Colors.deepPurple.shade50,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          _resultado,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// =====================
/// 4. PÁGINA PRINCIPAL CON TABS
/// =====================

class ClubPage extends StatelessWidget {
  const ClubPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Control de Peso - Club"),
          bottom: const TabBar(
            isScrollable: true,
            tabs: [
              Tab(icon: Icon(Icons.person), text: "Persona 1"),
              Tab(icon: Icon(Icons.person), text: "Persona 2"),
              Tab(icon: Icon(Icons.person), text: "Persona 3"),
              Tab(icon: Icon(Icons.person), text: "Persona 4"),
              Tab(icon: Icon(Icons.person), text: "Persona 5"),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            PersonaCard(titulo: "Datos de Persona 1"),
            PersonaCard(titulo: "Datos de Persona 2"),
            PersonaCard(titulo: "Datos de Persona 3"),
            PersonaCard(titulo: "Datos de Persona 4"),
            PersonaCard(titulo: "Datos de Persona 5"),
          ],
        ),
      ),
    );
  }
}
