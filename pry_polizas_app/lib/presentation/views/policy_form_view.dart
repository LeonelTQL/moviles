import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/policy_entity.dart';
import '../viewmodels/policy_viewmodel.dart';

class PolicyFormView extends StatefulWidget {
  final PolicyEntity? policy;

  const PolicyFormView({super.key, this.policy});

  @override
  State<PolicyFormView> createState() => _PolicyFormViewState();
}

class _PolicyFormViewState extends State<PolicyFormView> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _codigoController;
  late final TextEditingController _clienteController;
  late final TextEditingController _tipoSeguroController;
  late final TextEditingController _fechaInicioController;
  late final TextEditingController _fechaVencimientoController;
  late final TextEditingController _valorAseguradoController;

  bool get _isEditing => widget.policy != null;

  @override
  void initState() {
    super.initState();
    final policy = widget.policy;
    _codigoController = TextEditingController(text: policy?.codigo ?? '');
    _clienteController = TextEditingController(text: policy?.cliente ?? '');
    _tipoSeguroController = TextEditingController(text: policy?.tipoSeguro ?? '');
    _fechaInicioController = TextEditingController(text: policy?.fechaInicio ?? '');
    _fechaVencimientoController = TextEditingController(text: policy?.fechaVencimiento ?? '');
    _valorAseguradoController = TextEditingController(
      text: policy == null ? '' : policy.valorAsegurado.toStringAsFixed(2),
    );
  }

  @override
  void dispose() {
    _codigoController.dispose();
    _clienteController.dispose();
    _tipoSeguroController.dispose();
    _fechaInicioController.dispose();
    _fechaVencimientoController.dispose();
    _valorAseguradoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<PolicyViewModel>();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(18),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEFF6FF),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Icon(
                      _isEditing ? Icons.edit_note_rounded : Icons.add_card_rounded,
                      color: const Color(0xFF1E3A8A),
                      size: 32,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _isEditing ? 'Actualizar datos' : 'Nueva póliza',
                          style: const TextStyle(fontSize: 21, fontWeight: FontWeight.w900),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _isEditing ? 'Edita la información del cliente.' : 'Completa los campos solicitados.',
                          style: const TextStyle(color: Color(0xFF64748B)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  children: [
                    TextFormField(
                      controller: _codigoController,
                      enabled: !_isEditing,
                      textCapitalization: TextCapitalization.characters,
                      decoration: const InputDecoration(
                        labelText: 'Código',
                        hintText: 'Ej. POL-001',
                        prefixIcon: Icon(Icons.confirmation_number_outlined),
                      ),
                      validator: _requiredValidator,
                    ),
                    const SizedBox(height: 13),
                    TextFormField(
                      controller: _clienteController,
                      textCapitalization: TextCapitalization.words,
                      decoration: const InputDecoration(
                        labelText: 'Cliente',
                        hintText: 'Nombre del cliente',
                        prefixIcon: Icon(Icons.person_outline_rounded),
                      ),
                      validator: _requiredValidator,
                    ),
                    const SizedBox(height: 13),
                    TextFormField(
                      controller: _tipoSeguroController,
                      textCapitalization: TextCapitalization.words,
                      decoration: const InputDecoration(
                        labelText: 'Tipo de seguro',
                        hintText: 'Vehicular, Salud, Vida, Hogar...',
                        prefixIcon: Icon(Icons.security_outlined),
                      ),
                      validator: _requiredValidator,
                    ),
                    const SizedBox(height: 13),
                    TextFormField(
                      controller: _fechaInicioController,
                      readOnly: true,
                      decoration: const InputDecoration(
                        labelText: 'Fecha de inicio',
                        hintText: 'AAAA-MM-DD',
                        prefixIcon: Icon(Icons.calendar_today_outlined),
                      ),
                      onTap: () => _selectDate(_fechaInicioController),
                      validator: _dateValidator,
                    ),
                    const SizedBox(height: 13),
                    TextFormField(
                      controller: _fechaVencimientoController,
                      readOnly: true,
                      decoration: const InputDecoration(
                        labelText: 'Fecha de vencimiento',
                        hintText: 'AAAA-MM-DD',
                        prefixIcon: Icon(Icons.event_available_outlined),
                      ),
                      onTap: () => _selectDate(_fechaVencimientoController),
                      validator: _dateValidator,
                    ),
                    const SizedBox(height: 13),
                    TextFormField(
                      controller: _valorAseguradoController,
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                      ],
                      decoration: const InputDecoration(
                        labelText: 'Valor asegurado',
                        hintText: 'Ej. 15000',
                        prefixIcon: Icon(Icons.attach_money_rounded),
                      ),
                      validator: _valueValidator,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 14),
            if (viewModel.errorMessage != null)
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF1F2),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.warning_amber_rounded, color: Color(0xFFBE123C)),
                    const SizedBox(width: 10),
                    Expanded(child: Text(viewModel.errorMessage!)),
                  ],
                ),
              ),
            if (viewModel.isLoading) ...[
              const SizedBox(height: 12),
              const LinearProgressIndicator(minHeight: 6),
            ],
            const SizedBox(height: 18),
            FilledButton.icon(
              onPressed: viewModel.isLoading ? null : _savePolicy,
              icon: Icon(_isEditing ? Icons.save_rounded : Icons.add_rounded),
              label: Text(_isEditing ? 'Actualizar póliza' : 'Registrar póliza'),
            ),
            if (!_isEditing) ...[
              const SizedBox(height: 8),
              TextButton.icon(
                onPressed: viewModel.isLoading ? null : _clearForm,
                icon: const Icon(Icons.cleaning_services_outlined),
                label: const Text('Limpiar formulario'),
              ),
            ],
          ],
        ),
      ),
    );
  }

  String? _requiredValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Campo obligatorio';
    }
    if (value.trim().length < 3) {
      return 'Debe tener al menos 3 caracteres';
    }
    return null;
  }

  String? _dateValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Campo obligatorio';
    }
    if (DateTime.tryParse(value.trim()) == null) {
      return 'Seleccione una fecha válida';
    }
    return null;
  }

  String? _valueValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Campo obligatorio';
    }
    final number = double.tryParse(value.trim());
    if (number == null || number <= 0) {
      return 'Ingrese un valor mayor a 0';
    }
    return null;
  }

  Future<void> _selectDate(TextEditingController controller) async {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    // Determinar la fecha mínima permitida
    DateTime firstDate = DateTime(2000);
    if (controller == _fechaInicioController) {
      firstDate = today;
    } else if (controller == _fechaVencimientoController && _fechaInicioController.text.isNotEmpty) {
      final startDate = DateTime.parse(_fechaInicioController.text);
      // Mínimo un mes después de la fecha de inicio
      firstDate = DateTime(startDate.year, startDate.month + 1, startDate.day);
    }

    final currentTextDate = DateTime.tryParse(controller.text);
    DateTime initialDate = currentTextDate ?? firstDate;
    
    // Asegurar que initialDate esté dentro del rango [firstDate, lastDate]
    if (initialDate.isBefore(firstDate)) {
      initialDate = firstDate;
    }

    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: DateTime(2035),
      helpText: 'Seleccionar fecha',
      cancelText: 'Cancelar',
      confirmText: 'Aceptar',
    );

    if (picked == null) return;
    controller.text = picked.toIso8601String().split('T').first;

    // Si se cambia la fecha de inicio, validar que la de vencimiento siga siendo válida
    if (controller == _fechaInicioController && _fechaVencimientoController.text.isNotEmpty) {
      final start = picked;
      final end = DateTime.parse(_fechaVencimientoController.text);
      final minEnd = DateTime(start.year, start.month + 1, start.day);
      
      if (end.isBefore(minEnd)) {
        _fechaVencimientoController.clear();
      }
    }
  }

  Future<void> _savePolicy() async {
    if (!_formKey.currentState!.validate()) return;

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final startDate = DateTime.parse(_fechaInicioController.text);
    final endDate = DateTime.parse(_fechaVencimientoController.text);

    // 1. Fecha de inicio no puede ser menor a la actual
    if (startDate.isBefore(today)) {
      _showMessage('La fecha de inicio no puede ser anterior a la fecha actual');
      return;
    }

    // 2. Fecha de vencimiento debe ser mayor a la de inicio
    if (!endDate.isAfter(startDate)) {
      _showMessage('La fecha de vencimiento debe ser posterior a la de inicio');
      return;
    }

    // 3. Diferencia mínima de un mes
    final minEndDate = DateTime(startDate.year, startDate.month + 1, startDate.day);
    if (endDate.isBefore(minEndDate)) {
      _showMessage('La vigencia mínima de la póliza debe ser de al menos un mes');
      return;
    }

    final policy = PolicyEntity(
      codigo: _codigoController.text.trim().toUpperCase(),
      cliente: _clienteController.text.trim(),
      tipoSeguro: _tipoSeguroController.text.trim(),
      fechaInicio: _fechaInicioController.text.trim(),
      fechaVencimiento: _fechaVencimientoController.text.trim(),
      valorAsegurado: double.parse(_valorAseguradoController.text.trim()),
    );

    final viewModel = context.read<PolicyViewModel>();
    final success = _isEditing
        ? await viewModel.updatePolicy(policy)
        : await viewModel.createPolicy(policy);

    if (!mounted) return;

    if (success) {
      _showMessage(_isEditing ? 'Póliza actualizada correctamente' : 'Póliza registrada correctamente');
      if (_isEditing) {
        Navigator.pop(context);
      } else {
        _clearForm();
        viewModel.changeTab(1);
      }
    } else {
      _showMessage(viewModel.errorMessage ?? 'No se pudo guardar la póliza');
    }
  }

  void _clearForm() {
    _codigoController.clear();
    _clienteController.clear();
    _tipoSeguroController.clear();
    _fechaInicioController.clear();
    _fechaVencimientoController.clear();
    _valorAseguradoController.clear();
    context.read<PolicyViewModel>().clearError();
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(message),
      ),
    );
  }
}
