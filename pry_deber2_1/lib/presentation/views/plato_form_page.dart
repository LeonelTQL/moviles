import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/entities/plato.dart';
import '../viewmodels/plato_viewmodel.dart';

class PlatoFormPage extends StatefulWidget {
  final Plato? plato;

  const PlatoFormPage({super.key, this.plato});

  @override
  State<PlatoFormPage> createState() => _PlatoFormPageState();
}

class _PlatoFormPageState extends State<PlatoFormPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nombreController;
  late TextEditingController _descripcionController;
  late TextEditingController _precioController;
  late TextEditingController _imagenUrlController;
  bool _disponible = true;

  @override
  void initState() {
    super.initState();
    _nombreController = TextEditingController(text: widget.plato?.nombre ?? '');
    _descripcionController = TextEditingController(text: widget.plato?.descripcion ?? '');
    _precioController = TextEditingController(text: widget.plato?.precio.toString() ?? '');
    _imagenUrlController = TextEditingController(text: widget.plato?.imagenUrl ?? '');
    _disponible = widget.plato?.disponible ?? true;
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _descripcionController.dispose();
    _precioController.dispose();
    _imagenUrlController.dispose();
    super.dispose();
  }

  void _saveForm() async {
    if (_formKey.currentState!.validate()) {
      final plato = Plato(
        id: widget.plato?.id,
        nombre: _nombreController.text,
        descripcion: _descripcionController.text,
        precio: double.parse(_precioController.text),
        disponible: _disponible,
        imagenUrl: _imagenUrlController.text,
      );

      try {
        if (widget.plato == null) {
          await context.read<PlatoViewModel>().addPlato(plato);
        } else {
          await context.read<PlatoViewModel>().editPlato(plato);
        }
        if (mounted) Navigator.pop(context);
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: $e')),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.plato != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Editar Plato' : 'Nuevo Plato'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: _nombreController,
                  decoration: const InputDecoration(labelText: 'Nombre del Plato'),
                  validator: (value) => value == null || value.isEmpty ? 'Requerido' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _descripcionController,
                  decoration: const InputDecoration(labelText: 'Descripción'),
                  maxLines: 3,
                  validator: (value) => value == null || value.isEmpty ? 'Requerido' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _precioController,
                  decoration: const InputDecoration(labelText: 'Precio', prefixText: '\$ '),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Requerido';
                    if (double.tryParse(value) == null) return 'Precio inválido';
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _imagenUrlController,
                  decoration: const InputDecoration(labelText: 'URL de Imagen'),
                ),
                const SizedBox(height: 16),
                SwitchListTile(
                  title: const Text('Disponible'),
                  value: _disponible,
                  onChanged: (val) => setState(() => _disponible = val),
                  activeColor: Colors.deepOrange,
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _saveForm,
                    child: Text(isEditing ? 'GUARDAR CAMBIOS' : 'CREAR PLATO'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
