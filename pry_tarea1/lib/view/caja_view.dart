import 'package:flutter/material.dart';
import '../controller/caja_controller.dart';

// ================= ÁTOMOS =================

class Label extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color? color;

  const Label(this.text, {super.key, this.fontSize = 20, this.color});

  @override
  Widget build(BuildContext context) => Text(
    text,
    textAlign: TextAlign.center,
    style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: color),
  );
}

class MoneyField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;

  const MoneyField({super.key, required this.controller, required this.hint});

  @override
  Widget build(BuildContext context) => TextField(
    controller: controller,
    keyboardType: const TextInputType.numberWithOptions(decimal: true),
    decoration: InputDecoration(
        hintText: hint,
        prefixIcon: const Icon(Icons.attach_money),
        border: const OutlineInputBorder()),
  );
}

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? color;

  const PrimaryButton({super.key, required this.text, required this.onPressed, this.color});

  @override
  Widget build(BuildContext context) => ElevatedButton(
    style: ElevatedButton.styleFrom(backgroundColor: color),
    onPressed: onPressed,
    child: Text(text),
  );
}

// ================= MOLÉCULAS =================

class ControlesCajero extends StatelessWidget {
  final VoidCallback onAgregar;
  final VoidCallback onCobrar;
  final VoidCallback onReporte;

  const ControlesCajero({
    super.key,
    required this.onAgregar,
    required this.onCobrar,
    required this.onReporte,
  });

  @override
  Widget build(BuildContext context) => Wrap(
    spacing: 10,
    runSpacing: 10,
    alignment: WrapAlignment.center,
    children: [
      PrimaryButton(text: 'Agregar Artículo', onPressed: onAgregar),
      PrimaryButton(text: 'Cobrar al Cliente', onPressed: onCobrar, color: Colors.green),
      PrimaryButton(text: 'Reporte Supervisor', onPressed: onReporte, color: Colors.orange),
    ],
  );
}

// ================= ORGANISMOS =================

class CajaCard extends StatefulWidget {
  const CajaCard({super.key});

  @override
  State<StatefulWidget> createState() => _CajaCardState();
}

class _CajaCardState extends State<CajaCard> {
  final _precioController = TextEditingController();
  final _controller = CajaController();
  String _pantalla = 'Caja abierta. Ingrese el primer artículo.';

  void _agregarArticulo() {
    setState(() {
      _pantalla = _controller.procesarArticulo(_precioController.text);
      _precioController.clear();
    });
  }

  void _cobrarCliente() {
    setState(() {
      _pantalla = _controller.procesarFinCliente();
      _precioController.clear();
    });
  }

  void _mostrarReporte() {
    setState(() {
      _pantalla = _controller.procesarReporteSupervisor();
      _precioController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Label('Lector de Precios'),
            const SizedBox(height: 15),
            MoneyField(controller: _precioController, hint: 'Ej: 1.50'),
            const SizedBox(height: 15),
            ControlesCajero(
              onAgregar: _agregarArticulo,
              onCobrar: _cobrarCliente,
              onReporte: _mostrarReporte,
            ),
            const SizedBox(height: 25),
            const Divider(),
            const SizedBox(height: 10),
            const Label('Pantalla del Cajero:', fontSize: 16, color: Colors.grey),
            const SizedBox(height: 10),
            Label(_pantalla, fontSize: 18, color: Colors.blueAccent),
          ],
        ),
      ),
    );
  }
}

// ================= PÁGINAS =================

class CajaPage extends StatelessWidget {
  const CajaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sistema de Caja - Supermercado')),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: CajaCard(),
        ),
      ),
    );
  }
}