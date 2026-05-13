import 'package:flutter/material.dart';

import '../controllers/cantidades_controlador.dart';
import '../models/cantidades_modelo.dart';
import '../widgets/moleculas/mensaje_error.dart';
import '../widgets/moleculas/encabezado_ejercicio.dart';
import '../widgets/organismos/formulario_cantidades.dart';
import '../widgets/organismos/resultado_cantidades.dart';

class VistaCantidades extends StatefulWidget {
  const VistaCantidades({super.key});

  @override
  State<VistaCantidades> createState() => _VistaCantidadesState();
}

class _VistaCantidadesState extends State<VistaCantidades> {
  final CantidadesControlador _controlador = CantidadesControlador();

  final TextEditingController _cantidadesController =
      TextEditingController(text: '-2, 0, 5, -8, 0, 12');

  ResultadoCantidadesModelo? _resultado;
  String? _error;
  int _cantidadIngresada = 0;

  @override
  void initState() {
    super.initState();
    _actualizarCantidadIngresada();
    _cantidadesController.addListener(_actualizarCantidadIngresada);
  }

  @override
  void dispose() {
    _cantidadesController.removeListener(_actualizarCantidadIngresada);
    _cantidadesController.dispose();
    super.dispose();
  }

  void _actualizarCantidadIngresada() {
    final int cantidad = _contarCantidadesIngresadas(
      _cantidadesController.text,
    );

    setState(() {
      _cantidadIngresada = cantidad;
    });
  }

  int _contarCantidadesIngresadas(String texto) {
    return texto
        .split(RegExp(r'[\s,;]+'))
        .where((valor) => valor.trim().isNotEmpty)
        .length;
  }

  void _calcular() {
    final respuesta = _controlador.procesar(
      cantidadesTexto: _cantidadesController.text,
    );

    setState(() {
      _error = respuesta.error;
      _resultado = respuesta.datos;
    });
  }

  void _limpiar() {
    setState(() {
      _cantidadesController.clear();
      _resultado = null;
      _error = null;
      _cantidadIngresada = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Problema 4.3'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const EncabezadoEjercicio(
                titulo: 'Conteo de cantidades',
                descripcion:
                    'Ingrese varias cantidades separadas por coma, punto y coma o espacios. La aplicación contará cuántas son cero, menores a cero y mayores a cero.',
              ),
              const SizedBox(height: 16),
              FormularioCantidades(
                cantidadesController: _cantidadesController,
                cantidadIngresada: _cantidadIngresada,
                onCalcular: _calcular,
                onLimpiar: _limpiar,
              ),
              if (_error != null) ...[
                const SizedBox(height: 12),
                MensajeError(mensaje: _error!),
              ],
              if (_resultado != null) ...[
                const SizedBox(height: 12),
                ResultadoCantidades(resultado: _resultado!),
              ],
            ],
          ),
        ),
      ),
    );
  }
}