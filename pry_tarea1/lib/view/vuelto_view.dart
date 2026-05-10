import 'package:flutter/material.dart';
import '../controller/vuelto_controller.dart';

// ================= ÁTOMOS =================

class Label extends StatelessWidget {
  final String text;
  final bool isBold;

  const Label(this.text, {super.key, this.isBold = true});

  @override
  Widget build(BuildContext context) => Text(
    text,
    style: TextStyle(
        fontSize: 18,
        fontWeight: isBold ? FontWeight.bold : FontWeight.normal
    ),
  );
}

class DecimalField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;

  const DecimalField({super.key, required this.controller, required this.hint});

  @override
  Widget build(BuildContext context) => TextField(
    controller: controller,
    keyboardType: const TextInputType.numberWithOptions(decimal: true),
    decoration: InputDecoration(
        hintText: hint,
        prefixIcon: const Icon(Icons.attach_money),
        border: const OutlineInputBorder()
    ),
  );
}

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const PrimaryButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) => ElevatedButton(
    style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50)
    ),
    onPressed: onPressed,
    child: Text(text, style: const TextStyle(fontSize: 16)),
  );
}

// ================= MOLÉCULAS =================

class DoubleInput extends StatelessWidget {
  final TextEditingController controllerPrecio;
  final TextEditingController controllerPago;

  const DoubleInput({
    super.key,
    required this.controllerPrecio,
    required this.controllerPago
  });

  @override
  Widget build(BuildContext context) => Row(
    children: [
      Expanded(child: DecimalField(controller: controllerPrecio, hint: 'Precio Artículo')),
      const SizedBox(width: 15),
      Expanded(child: DecimalField(controller: controllerPago, hint: 'Pago Cliente')),
    ],
  );
}

// ================= ORGANISMOS =================

class VueltoCard extends StatefulWidget {
  const VueltoCard({super.key});

  @override
  State<StatefulWidget> createState() => _VueltoCardState();
}

class _VueltoCardState extends State<VueltoCard> {
  final _precioController = TextEditingController();
  final _pagoController = TextEditingController();
  final _controller = VueltoController();
  String _resultado = 'Ingrese los valores para calcular el vuelto.';

  void _calcular() {
    setState(() {
      _resultado = _controller.procesar(_precioController.text, _pagoController.text);
      // Opcional: Ocultar el teclado al calcular
      FocusScope.of(context).unfocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(child: Label('Cálculo de Cambio Mínimo')),
            const SizedBox(height: 20),
            DoubleInput(controllerPrecio: _precioController, controllerPago: _pagoController),
            const SizedBox(height: 20),
            PrimaryButton(text: 'Calcular Vuelto', onPressed: _calcular),
            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 10),
            Label(_resultado, isBold: false),
          ],
        ),
      ),
    );
  }
}

// ================= PÁGINAS =================

class VueltoPage extends StatelessWidget {
  const VueltoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Máquina de Vuelto')),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: VueltoCard(),
      ),
    );
  }
}