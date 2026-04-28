import 'package:flutter/material.dart';
import '../controller/conteo_controller.dart';

/// 1. ÁTOMOS

class Label extends StatelessWidget {
  final String text;

  const Label(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
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
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(text),
    );
  }
}

/// 2. ORGANISMO (DINÁMICO)

class NumerosCard extends StatefulWidget {
  const NumerosCard({super.key});

  @override
  State<NumerosCard> createState() => _NumerosCardState();
}

class _NumerosCardState extends State<NumerosCard> {

  final List<TextEditingController> _controllers = [
    TextEditingController()
  ];

  final _controller = conteoController();

  String _resultado = "";

  void _agregarCampoSiEsNecesario(int index) {
    if (index == _controllers.length - 1 &&
        _controllers[index].text.trim().isNotEmpty) {

      setState(() {
        _controllers.add(TextEditingController());
      });
    }
  }

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
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [

            const Label("Ingrese números"),

            const SizedBox(height: 10),

            SizedBox(
              height: 400,
              child: ListView.builder(
                itemCount: _controllers.length,
                itemBuilder: (context, i) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: TextField(
                      controller: _controllers[i],
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Número ${i + 1}",
                        border: const OutlineInputBorder(),
                      ),
                      onChanged: (_) => _agregarCampoSiEsNecesario(i),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 10),

            PrimaryButton(
              text: "Calcular",
              onPressed: _calcular,
            ),

            const SizedBox(height: 10),

            Text(_resultado),
          ],
        ),
      ),
    );
  }
}

/// 3. PÁGINA

class NumerosPage extends StatelessWidget {
  const NumerosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Análisis de números"),
      ),
      body: const SingleChildScrollView(
        child: NumerosCard(),
      ),
    );
  }
}