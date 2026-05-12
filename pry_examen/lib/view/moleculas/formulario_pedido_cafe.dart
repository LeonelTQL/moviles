import 'package:flutter/material.dart';
import '../atomos/campo_texto.dart';
import '../atomos/selector_producto.dart';
import '../atomos/selector_tamano.dart';
import '../atomos/boton_principal.dart';

class FormularioPedidoCafe extends StatefulWidget {
  final Function(String cliente, String producto, String tamano, int cantidad) onProcesar;

  const FormularioPedidoCafe({super.key, required this.onProcesar});

  @override
  State<FormularioPedidoCafe> createState() => _FormularioPedidoCafeState();
}

class _FormularioPedidoCafeState extends State<FormularioPedidoCafe> {
  final _clienteController = TextEditingController();
  final _cantidadController = TextEditingController();
  String? _producto;
  String? _tamano;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CampoTexto(label: 'Nombre del Cliente', controller: _clienteController),
        const SizedBox(height: 16),
        SelectorProducto(
          value: _producto,
          onChanged: (val) => setState(() => _producto = val),
        ),
        const SizedBox(height: 16),
        SelectorTamano(
          value: _tamano,
          onChanged: (val) => setState(() => _tamano = val),
        ),
        const SizedBox(height: 16),
        CampoTexto(
          label: 'Cantidad',
          controller: _cantidadController,
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 24),
        BotonPrincipal(
          texto: 'Calcular y Generar Nota',
          onPressed: () {
            int cantidad = int.tryParse(_cantidadController.text) ?? 0;
            widget.onProcesar(
              _clienteController.text,
              _producto ?? '',
              _tamano ?? '',
              cantidad,
            );
          },
        ),
      ],
    );
  }
}
