import 'package:flutter/material.dart';
import '../controllers/hamburguesa_controller.dart';
import '../widgets/atomos/texto_titulo_app.dart';
import '../widgets/moleculas/mol_input.dart';
import '../widgets/atomos/boton_principal_app.dart';

// ================= MOLÉCULAS =================

// Un input con su etiqueta al lado para pedir cada tipo de hamburguesa
class BurgerInputRow extends StatelessWidget {
  final String label;
  final TextEditingController controller;

  const BurgerInputRow({super.key, required this.label, required this.controller});

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Row(
      children: [
        Expanded(flex: 2, child: Text(label, style: Theme.of(context).textTheme.bodyLarge)),
        const SizedBox(width: 12),
        Expanded(flex: 1, child: MolInput(controller: controller, label: '0', keyboardType: TextInputType.number)),
      ],
    ),
  );
}


// Un switch con su etiqueta para saber si paga con tarjeta
class PaymentSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const PaymentSwitch({super.key, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text('¿Pagar con Tarjeta de Crédito? (+5%)', style: Theme.of(context).textTheme.bodyLarge),
      Switch(value: value, onChanged: onChanged),
    ],
  );
}

// ================= ORGANISMOS =================

class PedidoCard extends StatefulWidget {
  const PedidoCard({super.key});

  @override
  State<StatefulWidget> createState() => _PedidoCardState();
}

class _PedidoCardState extends State<PedidoCard> {
  final _sencillasCtrl = TextEditingController();
  final _doblesCtrl = TextEditingController();
  final _triplesCtrl = TextEditingController();

  bool _pagoTarjeta = false;
  final _controller = HamburguesaController();
  String _resultado = 'Arma tu pedido para ver el total.';

  void _calcular() {
    setState(() {
      _resultado = _controller.procesarPedido(
          _sencillasCtrl.text,
          _doblesCtrl.text,
          _triplesCtrl.text,
          _pagoTarjeta
      );
      FocusScope.of(context).unfocus(); // Oculta el teclado
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(child: TextoTituloApp('Menú: El Náufrago Satisfecho')),
            const SizedBox(height: 20),

            BurgerInputRow(label: 'Sencillas (\$20)', controller: _sencillasCtrl),
            BurgerInputRow(label: 'Dobles (\$25)', controller: _doblesCtrl),
            BurgerInputRow(label: 'Triples (\$28)', controller: _triplesCtrl),

            const Divider(),
            PaymentSwitch(
              value: _pagoTarjeta,
              onChanged: (val) => setState(() => _pagoTarjeta = val),
            ),

            const SizedBox(height: 20),
            BotonPrincipalApp(texto: 'Calcular Total', icono: Icons.receipt_long, onPressed: _calcular),

            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(_resultado, style: TextStyle(
                fontFamily: 'monospace', 
                fontSize: 14,
                color: Theme.of(context).colorScheme.onPrimaryContainer
              )),
            )
          ],
        ),
      ),
    );
  }
}

// ================= PÁGINAS =================

class HamburguesaView extends StatelessWidget {
  const HamburguesaView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hamburguesas')),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: PedidoCard(),
      ),
    );
  }
}