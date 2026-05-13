import 'package:flutter/material.dart';
import '../controllers/venta_controller.dart';
import '../widgets/atomos/boton_principal_app.dart';
import '../widgets/moleculas/mol_input.dart';
import '../widgets/moleculas/mol_producto_item.dart';
import '../widgets/moleculas/encabezado_ejercicio.dart';

class RegistroVentaView extends StatefulWidget {
  const RegistroVentaView({super.key});

  @override
  State<RegistroVentaView> createState() => _RegistroVentaViewState();
}

class _RegistroVentaViewState extends State<RegistroVentaView> {
  final _controller = VentaController();


  final _vendedorInput = TextEditingController();
  final _clienteInput = TextEditingController();


  final _prodNombreInput = TextEditingController();
  final _prodPrecioInput = TextEditingController();
  final _prodCantidadInput = TextEditingController();


  final List<Map<String, dynamic>> _productosAgregados = [];

  void _agregarProducto() {
    final nombre = _prodNombreInput.text;
    final precio = double.tryParse(_prodPrecioInput.text);
    final cantidad = int.tryParse(_prodCantidadInput.text);

    if (nombre.isNotEmpty && precio != null && cantidad != null && cantidad > 0) {
      setState(() {
        _productosAgregados.add({
          'nombre': nombre,
          'precio': precio,
          'cantidad': cantidad,
        });
      });

      _prodNombreInput.clear();
      _prodPrecioInput.clear();
      _prodCantidadInput.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Revise los datos del producto.")),
      );
    }
  }

  void _eliminarProducto(int index) {
    setState(() {
      _productosAgregados.removeAt(index);
    });
  }

  void _procesarVenta() {
    final resultado = _controller.procesarTransaccion(
      nombreVendedor: _vendedorInput.text,
      nombreCliente: _clienteInput.text,
      listaProductosAnadidos: _productosAgregados,
    );

    Navigator.pushNamed(context, '/resultado_ventas', arguments: resultado);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Registro de Ventas")),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const EncabezadoEjercicio(
            titulo: 'Sistema de Ventas', 
            descripcion: 'Registre los datos de la operación y añada productos al carrito para calcular el total.'
          ),
          const SizedBox(height: 20),
          Text("Datos de la Operación", style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          MolInput(controller: _vendedorInput, label: "Vendedor"),
          const SizedBox(height: 10),
          MolInput(controller: _clienteInput, label: "Cliente"),
          const Divider(height: 30),

          Text("Agregar Producto", style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          MolInput(controller: _prodNombreInput, label: "Nombre del Producto"),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: MolInput(
                    controller: _prodPrecioInput,
                    label: "Precio (\$)",
                    keyboardType: TextInputType.number
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: MolInput(
                    controller: _prodCantidadInput,
                    label: "Cantidad",
                    keyboardType: TextInputType.number
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: _agregarProducto,
            icon: const Icon(Icons.add_shopping_cart),
            label: const Text("Agregar a la lista"),
          ),
          const Divider(height: 30),

          Text("Productos en el Carrito (${_productosAgregados.length})",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Theme.of(context).colorScheme.primary)),

          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _productosAgregados.length,
            itemBuilder: (context, index) {
              final prod = _productosAgregados[index];
              return MolProductoItem(
                nombre: prod['nombre'],
                cantidad: prod['cantidad'],
                total: prod['precio'] * prod['cantidad'],
                onEliminar: () => _eliminarProducto(index),
              );
            },
          ),
          const SizedBox(height: 24),

          BotonPrincipalApp(
            texto: "Calcular Venta Completa", 
            icono: Icons.calculate, 
            onPressed: _procesarVenta
          ),
        ],
      ),
    );
  }
}