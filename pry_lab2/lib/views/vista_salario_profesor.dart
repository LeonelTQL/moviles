import 'package:flutter/material.dart';

import '../controllers/salario_profesor_controlador.dart';
import '../models/salario_profesor_modelo.dart';
import '../widgets/moleculas/encabezado_ejercicio.dart';
import '../widgets/moleculas/mensaje_error.dart';
import '../widgets/organismos/formulario_salario_profesor.dart';
import '../widgets/organismos/resultado_salario_profesor.dart';

class VistaSalarioProfesor extends StatefulWidget {
  const VistaSalarioProfesor({super.key});

  @override
  State<VistaSalarioProfesor> createState() => _VistaSalarioProfesorState();
}

class _VistaSalarioProfesorState extends State<VistaSalarioProfesor> {
  final SalarioProfesorControlador _controlador = SalarioProfesorControlador();
  final TextEditingController _salarioInicialController =
      TextEditingController(text: '1500');
  final TextEditingController _porcentajeIncrementoController =
      TextEditingController(text: '10');
  final TextEditingController _aniosController = TextEditingController(text: '6');

  ResultadoSalarioProfesorModelo? _resultado;
  String? _error;

  @override
  void dispose() {
    _salarioInicialController.dispose();
    _porcentajeIncrementoController.dispose();
    _aniosController.dispose();
    super.dispose();
  }

  void _calcular() {
    final respuesta = _controlador.procesar(
      salarioInicialTexto: _salarioInicialController.text,
      porcentajeIncrementoTexto: _porcentajeIncrementoController.text,
      aniosTexto: _aniosController.text,
    );

    setState(() {
      _error = respuesta.error;
      _resultado = respuesta.datos;
    });
  }

  void _limpiar() {
    setState(() {
      _salarioInicialController.text = '1500';
      _porcentajeIncrementoController.text = '10';
      _aniosController.text = '6';
      _resultado = null;
      _error = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Problema 4.1'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const EncabezadoEjercicio(
                titulo: 'Salario de un profesor',
                descripcion:
                    'Calcula el salario anual aplicando un incremento porcentual durante varios años.',
              ),
              const SizedBox(height: 16),
              FormularioSalarioProfesor(
                salarioInicialController: _salarioInicialController,
                porcentajeIncrementoController: _porcentajeIncrementoController,
                aniosController: _aniosController,
                onCalcular: _calcular,
                onLimpiar: _limpiar,
              ),
              if (_error != null) ...[
                const SizedBox(height: 12),
                MensajeError(mensaje: _error!),
              ],
              if (_resultado != null) ...[
                const SizedBox(height: 12),
                ResultadoSalarioProfesor(resultado: _resultado!),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
