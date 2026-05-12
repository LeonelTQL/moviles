import 'package:flutter/material.dart';
import '../controller/nomina_controller.dart';
import '../widgets/atomos/atom_button.dart';
import '../widgets/moleculas/mol_input.dart';
import '../widgets/moleculas/mol_radio.dart';
import '../widgets/moleculas/mol_checkbox.dart';

class RegistroChoferView extends StatefulWidget {
  final NominaController controller;

  const RegistroChoferView({super.key, required this.controller});

  @override
  State<RegistroChoferView> createState() => _RegistroChoferViewState();
}

class _RegistroChoferViewState extends State<RegistroChoferView> {
  final _nombreInput = TextEditingController();
  final _sueldoInput = TextEditingController();

  final _horasLunes = TextEditingController();
  final _horasMartes = TextEditingController();
  final _horasMiercoles = TextEditingController();
  final _horasJueves = TextEditingController();
  final _horasViernes = TextEditingController();
  final _horasSabado = TextEditingController();

  String _tipoJornada = 'Diurna';
  bool _checkActivo = true;
  bool _checkBono = false;

  void _registrar() {
    final resultado = widget.controller.registrarChofer(
      nombre: _nombreInput.text,
      horasString: [
        _horasLunes.text, _horasMartes.text, _horasMiercoles.text,
        _horasJueves.text, _horasViernes.text, _horasSabado.text
      ],
      sueldoString: _sueldoInput.text,
      jornada: _tipoJornada,
      activo: _checkActivo,
      bono: _checkBono,
    );

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(resultado)));
    if (resultado.startsWith("Éxito")) _limpiarFormulario();
  }

  void _calcularReporte() {
    final reporteString = widget.controller.obtenerReporteFinal();
    Navigator.pushNamed(context, '/reporteNomina', arguments: reporteString);
  }

  void _limpiarFormulario() {
    setState(() {
      _nombreInput.clear();
      _sueldoInput.clear();
      _horasLunes.clear();
      _horasMartes.clear();
      _horasMiercoles.clear();
      _horasJueves.clear();
      _horasViernes.clear();
      _horasSabado.clear();
      _tipoJornada = 'Diurna';
      _checkActivo = true;
      _checkBono = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Registro de Choferes")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MolInput(controller: _nombreInput, label: "Nombre del Chofer"),
            const SizedBox(height: 16),
            MolInput(controller: _sueldoInput, label: "Sueldo por Hora (\$)", keyboardType: TextInputType.number),
            const SizedBox(height: 16),
            Text("Horas Trabajadas:", style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary)),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(child: MolInput(controller: _horasLunes, label: "Lun", keyboardType: TextInputType.number)),
                const SizedBox(width: 8),
                Expanded(child: MolInput(controller: _horasMartes, label: "Mar", keyboardType: TextInputType.number)),
                const SizedBox(width: 8),
                Expanded(child: MolInput(controller: _horasMiercoles, label: "Mié", keyboardType: TextInputType.number)),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(child: MolInput(controller: _horasJueves, label: "Jue", keyboardType: TextInputType.number)),
                const SizedBox(width: 8),
                Expanded(child: MolInput(controller: _horasViernes, label: "Vie", keyboardType: TextInputType.number)),
                const SizedBox(width: 8),
                Expanded(child: MolInput(controller: _horasSabado, label: "Sáb", keyboardType: TextInputType.number)),
              ],
            ),
            const SizedBox(height: 16),
            MolRadioGroup(
              title: "Tipo de Jornada",
              options: const ['Diurna', 'Nocturna', 'Mixta'],
              groupValue: _tipoJornada,
              onChanged: (val) => setState(() => _tipoJornada = val!),
            ),
            const SizedBox(height: 16),
            Text("Estados de Empleado:", style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary)),
            MolCheckbox(
              label: "Chofer Activo",
              value: _checkActivo,
              onChanged: (val) => setState(() => _checkActivo = val!),
            ),
            MolCheckbox(
              label: "Recibe Bono Semanal",
              value: _checkBono,
              onChanged: (val) => setState(() => _checkBono = val!),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                AtomButton(label: "Registrar", onPressed: _registrar, isPrimary: false),
                AtomButton(label: "Ver Nómina", onPressed: _calcularReporte),
              ],
            )
          ],
        ),
      ),
    );
  }
}
