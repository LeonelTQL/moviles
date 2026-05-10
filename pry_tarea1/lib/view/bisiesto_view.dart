import "package:flutter/material.dart";
import '../controller/bisiesto_controller.dart';

// 1. Átomos

class Label extends StatelessWidget {
  final String text;

  const Label(this.text, {super.key});

  @override
  Widget build(BuildContext context) => Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      );
}

class InfoText extends StatelessWidget {
  final String text;

  const InfoText(this.text, {super.key});

  @override
  Widget build(BuildContext context) => Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 14,
          color: Colors.black54,
        ),
      );
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
  Widget build(BuildContext context) => TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: hint,
          prefixIcon: const Icon(Icons.calendar_month),
          border: const OutlineInputBorder(),
        ),
      );
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
  Widget build(BuildContext context) => ElevatedButton(
        onPressed: onPressed,
        child: Text(text),
      );
}

class SecondaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const SecondaryButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) => OutlinedButton(
        onPressed: onPressed,
        child: Text(text),
      );
}

class ResultBox extends StatelessWidget {
  final String resultado;

  const ResultBox({
    super.key,
    required this.resultado,
  });

  @override
  Widget build(BuildContext context) => Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.deepPurple.withOpacity(0.08),
          border: Border.all(color: Colors.deepPurple),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          resultado,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
      );
}

// 2. Moléculas

class ActionButtons extends StatelessWidget {
  final VoidCallback onCalcular;
  final VoidCallback onLimpiar;

  const ActionButtons({
    super.key,
    required this.onCalcular,
    required this.onLimpiar,
  });

  @override
  Widget build(BuildContext context) => Row(
    children: [
      Expanded(
        child: PrimaryButton(
          text: "Verificar",
          onPressed: onCalcular,
        ),
      ),
      const SizedBox(width: 10),
      Expanded(
        child: SecondaryButton(
          text: "Limpiar",
          onPressed: onLimpiar,
        ),
      ),
    ],
  );
}

// 3. Organismos

class BisiestoCard extends StatefulWidget {
  const BisiestoCard({super.key});

  @override
  State<BisiestoCard> createState() => _BisiestoCardState();
}

class _BisiestoCardState extends State<BisiestoCard> {
  final anio = TextEditingController();
  final controller = BisiestoController();

  String resultado = "Ingrese un año para verificar si es bisiesto.";

  void calcular() {
    setState(() {
      resultado = controller.procesar(anio.text);
    });
  }

  void limpiar() {
    setState(() {
      anio.clear();
      resultado = "Ingrese un año para verificar si es bisiesto.";
    });
  }

  @override
  void dispose() {
    anio.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Card(
    margin: const EdgeInsets.symmetric(vertical: 10),
      elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,  //ocupa solo el espacio necesario para sus child
            children: [
              Icon(
                Icons.event_available,
                size: 50,
                color: Colors.deepPurple,
              ),
              SizedBox(height: 10),
              Label("Verificador de Año Bisiesto"),
              SizedBox(height: 10),
              InfoText(
                "Ingrese un año y la aplicación determinará si corresponde a un año bisiesto.",
              ),
              SizedBox(height: 20),
              NumberField(
                controller: anio,
                hint: "Ingrese el año",
              ),
              SizedBox(height: 15),
              ActionButtons(
                onCalcular: calcular,
                onLimpiar: limpiar,
              ),
              SizedBox(height: 20),
              ResultBox(resultado: resultado),
            ],
          ),
    ),
  );
}

// 4. Página

class BisiestoPagina extends StatelessWidget {
  const BisiestoPagina({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Año Bisiesto"),
        centerTitle: true,
      ),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: BisiestoCard(),
      ),
    );
  }
}