import 'package:flutter/material.dart';
import '../controller/pago_controller.dart';
import '../widgets/atomos/atom_button.dart';
import '../widgets/moleculas/mol_input.dart';
import '../widgets/moleculas/mol_radio.dart';
import '../widgets/moleculas/mol_checkbox.dart';

class RegistroPagoView extends StatefulWidget {
  @override
  State<RegistroPagoView> createState() => _RegistroPagoViewState();
}

class _RegistroPagoViewState extends State<RegistroPagoView> {
  final _controller = PagoController();

  final _clienteInput = TextEditingController();
  final _consumoInput = TextEditingController();

  String _servicioSeleccionado = 'Agua';
  String _formaPago = 'Efectivo';
  bool _checkMantenimiento = false;
  bool _checkSeguro = false;
  bool _checkDescuento = false;

  void _calcular() {
    final resultado = _controller.calcularPagoFinal(
      cliente: _clienteInput.text,
      servicio: _servicioSeleccionado,
      consumoString: _consumoInput.text,
      formaPago: _formaPago,
      checkMantenimiento: _checkMantenimiento,
      checkSeguro: _checkSeguro,
      checkDescuento: _checkDescuento,
    );

    Navigator.pushNamed(context, '/resumen', arguments: resultado);
  }

  void _limpiar() {
    setState(() {
      _clienteInput.clear();
      _consumoInput.clear();
      _servicioSeleccionado = 'Agua';
      _formaPago = 'Efectivo';
      _checkMantenimiento = false;
      _checkSeguro = false;
      _checkDescuento = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Registro de Consumo")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MolInput(controller: _clienteInput, label: "Nombre del Cliente"),
            SizedBox(height: 16),

            MolRadioGroup(
              title: "Tipo de Servicio",
              options: ['Agua', 'Energía eléctrica', 'Internet', 'Otros'],
              groupValue: _servicioSeleccionado,
              onChanged: (val) => setState(() => _servicioSeleccionado = val!),
            ),
            SizedBox(height: 16),

            MolInput(
                controller: _consumoInput,
                label: "Consumo o Valor Base (\$ / unid)",
                keyboardType: TextInputType.number
            ),
            SizedBox(height: 16),

            MolRadioGroup(
              title: "Forma de Pago",
              options: ['Efectivo', 'Tarjeta'],
              groupValue: _formaPago,
              onChanged: (val) => setState(() => _formaPago = val!),
            ),
            SizedBox(height: 16),


            Text("Descuentos:", style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary)),
            MolCheckbox(
              label: "Tercera Edad / Discapacidad (-50%)",
              value: _checkDescuento,
              onChanged: (val) => setState(() => _checkDescuento = val!),
            ),
            Divider(),


            Text("Servicios Adicionales (Recargos):", style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary)),
            MolCheckbox(
              label: "Mantenimiento Preventivo (+\$5)",
              value: _checkMantenimiento,
              onChanged: (val) => setState(() => _checkMantenimiento = val!),
            ),
            MolCheckbox(
              label: "Seguro Antidaños (+\$3.50)",
              value: _checkSeguro,
              onChanged: (val) => setState(() => _checkSeguro = val!),
            ),

            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                AtomButton(label: "Limpiar", onPressed: _limpiar, isPrimary: false),
                AtomButton(label: "Calcular", onPressed: _calcular),
              ],
            )
          ],
        ),
      ),
    );
  }
}