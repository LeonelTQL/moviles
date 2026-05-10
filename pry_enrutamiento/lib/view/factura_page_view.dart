import 'package:flutter/material.dart';
import '../controller/factura_controller.dart';
import '../model/factura_model.dart';

class FacturaPageView extends StatefulWidget {
  @override
  _FacturaPageViewState createState() => _FacturaPageViewState();
}

class _FacturaPageViewState extends State<FacturaPageView> {
  final FacturaController _controller = FacturaController();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _precioController = TextEditingController();
  
  final List<ProductoModel> _productos = [];

  void _agregarProducto() {
    final error = _controller.validarYAgregar(
      _nombreController.text,
      _precioController.text,
      _productos,
    );

    if (error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error), backgroundColor: Colors.redAccent),
      );
    } else {
      setState(() {
        _nombreController.clear();
        _precioController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final resultados = _controller.procesarFactura(_productos);

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text("Nueva Factura", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          _buildInputSection(),
          Expanded(
            child: _productos.isEmpty
                ? _buildEmptyState()
                : _buildProductList(),
          ),
          _buildSummarySection(resultados),
        ],
      ),
    );
  }

  Widget _buildInputSection() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.indigo,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        children: [
          TextField(
            controller: _nombreController,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              labelText: "Nombre del Producto",
              labelStyle: TextStyle(color: Colors.white70),
              prefixIcon: Icon(Icons.shopping_bag, color: Colors.white70),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white30),
                borderRadius: BorderRadius.circular(15),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
          SizedBox(height: 15),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _precioController,
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: "Precio",
                    labelStyle: TextStyle(color: Colors.white70),
                    prefixIcon: Icon(Icons.attach_money, color: Colors.white70),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white30),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 15),
              ElevatedButton(
                onPressed: _agregarProducto,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.indigo,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: Icon(Icons.add, size: 30),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.receipt_long, size: 80, color: Colors.grey[300]),
          SizedBox(height: 10),
          Text(
            "No hay productos todavía",
            style: TextStyle(color: Colors.grey[500], fontSize: 18),
          ),
        ],
      ),
    );
  }

  Widget _buildProductList() {
    return ListView.builder(
      padding: EdgeInsets.all(15),
      itemCount: _productos.length,
      itemBuilder: (context, index) {
        final producto = _productos[index];
        return Card(
          margin: EdgeInsets.only(bottom: 10),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: 2,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.indigo[50],
              child: Text("${index + 1}", style: TextStyle(color: Colors.indigo)),
            ),
            title: Text(producto.nombre, style: TextStyle(fontWeight: FontWeight.bold)),
            trailing: Text(
              "\$${producto.precio.toStringAsFixed(2)}",
              style: TextStyle(color: Colors.green[700], fontWeight: FontWeight.bold, fontSize: 16),
            ),
            onLongPress: () {
              setState(() {
                _productos.removeAt(index);
              });
            },
          ),
        );
      },
    );
  }

  Widget _buildSummarySection(Map<String, double> resultados) {
    final hasDiscount = resultados['descuento']! > 0;

    return Container(
      padding: EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, -5))
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Column(
        children: [
          _summaryRow("Subtotal", resultados['subtotal']!),
          if (hasDiscount) ...[
            SizedBox(height: 8),
            _summaryRow("Descuento (20%)", -resultados['descuento']!, color: Colors.red),
          ],
          Divider(height: 30, thickness: 1),
          _summaryRow("Total", resultados['total']!, isTotal: true),
          SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _productos.isEmpty ? null : () {
                Navigator.pushNamed(
                  context, 
                  '/factura_detalle', 
                  arguments: {
                    'productos': List<ProductoModel>.from(_productos),
                    'totales': resultados,
                  }
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              ),
              child: Text("GENERAR FACTURA", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _summaryRow(String label, double value, {bool isTotal = false, Color? color}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 20 : 16,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: color ?? Colors.black87,
          ),
        ),
        Text(
          "\$${value.toStringAsFixed(2)}",
          style: TextStyle(
            fontSize: isTotal ? 22 : 16,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.bold,
            color: color ?? (isTotal ? Colors.indigo : Colors.black87),
          ),
        ),
      ],
    );
  }
}
