import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/operario_viewmodel.dart';
import '../routes/app_routes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  final sueldoCtrl = TextEditingController();
  int antiguedad = 1;

  @override
  void dispose() {
    sueldoCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<OperarioViewmodel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Cálculos"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: sueldoCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Sueldo Base",
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              "Antigüedad en años",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            Expanded(
              child: ListView(
                children: [
                  for (int x = 1; x <= 15; x++)
                    RadioListTile<int>(
                      title: Text("$x años"),
                      value: x,
                      groupValue: antiguedad,
                      onChanged: (value) {
                        setState(() {
                          antiguedad = value!;
                        });
                      },
                    ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                final sueldo = double.tryParse(sueldoCtrl.text);

                if (sueldo == null || sueldo <= 0) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Sueldo inválido"),
                    ),
                  );
                  return;
                }

                final resultado = vm.calcular(
                  sueldo,
                  antiguedad.toDouble(),
                );

                Navigator.pushNamed(
                  context,
                  AppRoutes.resultado,
                  arguments: resultado,
                );
              },
              child: const Text("Calcular aumento"),
            ),
          ],
        ),
      ),
    );
  }
}