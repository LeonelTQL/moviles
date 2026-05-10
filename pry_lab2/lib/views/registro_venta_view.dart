import 'package:flutter/material.dart';
import '../controllers/venta_controller.dart';
import '../widgets/atomos/atom_button.dart';
import '../widgets/moleculas/mol_input.dart';
import '../widgets/moleculas/mol_producto_item.dart';

class RegistroVentaView extends StatefulWidget {
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


  List<Map<String, dynamic>> _productosAgregados = [];

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

    Navigator.pushNamed(context, '/resultado', arguments: resultado);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Registro de Transacción")),

      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [

          Text("Datos de la Operación", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          SizedBox(height: 10),
          MolInput(controller: _vendedorInput, label: "Vendedor"),
          SizedBox(height: 10),
          MolInput(controller: _clienteInput, label: "Cliente"),
          Divider(height: 30, thickness: 2),


          Text("Agregar Producto", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          SizedBox(height: 10),
          MolInput(controller: _prodNombreInput, label: "Nombre del Producto"),
          SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: MolInput(
                    controller: _prodPrecioInput,
                    label: "Precio (\$)",
                    keyboardType: TextInputType.number
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: MolInput(
                    controller: _prodCantidadInput,
                    label: "Cantidad",
                    keyboardType: TextInputType.number
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          ElevatedButton.icon(
            onPressed: _agregarProducto,
            icon: Icon(Icons.add_shopping_cart),
            label: Text("Agregar a la lista"),
          ),
          Divider(height: 30, thickness: 2),


          Text("Productos en el Carrito (${_productosAgregados.length})",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Theme.of(context).colorScheme.primary)),


          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
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
          SizedBox(height: 30),

          // Botón Final
          AtomButton(label: "Calcular Venta Completa", onPressed: _procesarVenta),
        ],
      ),
    );
  }
}