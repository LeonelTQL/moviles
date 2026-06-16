import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../themes/index.dart';
import '../../viewmodels/correo_viewmodel.dart';

class RedactarDialog extends StatefulWidget {
  const RedactarDialog({super.key});

  @override
  State<RedactarDialog> createState() => _RedactarDialogState();
}

class _RedactarDialogState extends State<RedactarDialog> {
  final _formKey = GlobalKey<FormState>();
  final _destinatarioController = TextEditingController();
  final _asuntoController = TextEditingController();
  final _mensajeController = TextEditingController();

  @override
  void dispose() {
    _destinatarioController.dispose();
    _asuntoController.dispose();
    _mensajeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<CorreoViewModel>();

    return AlertDialog(
      title: const Text('Redactar correo'),
      content: SizedBox(
        width: 420,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _destinatarioController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Destinatario',
                    prefixIcon: Icon(Icons.alternate_email),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Ingresa el destinatario';
                    }
                    if (!value.contains('@')) {
                      return 'Ingresa un correo válido';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _asuntoController,
                  decoration: const InputDecoration(
                    labelText: 'Asunto',
                    prefixIcon: Icon(Icons.subject),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Ingresa el asunto';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _mensajeController,
                  minLines: 4,
                  maxLines: 6,
                  decoration: const InputDecoration(
                    labelText: 'Mensaje',
                    alignLabelWithHint: true,
                    prefixIcon: Icon(Icons.message_outlined),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Ingresa el mensaje';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                const Text(
                  'Guardar simulado agrega el correo en memoria. Enviar Gmail real usa OAuth y Gmail API cuando configures Google Cloud.',
                  style: TextStyle(fontSize: 12, color: EsquemaColor.textoSecundario),
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: vm.procesandoGmail ? null : () => Navigator.pop(context),
          child: const Text('Cancelar'),
        ),
        OutlinedButton.icon(
          onPressed: vm.procesandoGmail ? null : _guardarSimulado,
          icon: const Icon(Icons.save_outlined),
          label: const Text('Guardar simulado'),
        ),
        ElevatedButton.icon(
          onPressed: vm.procesandoGmail ? null : _enviarGmailReal,
          icon: vm.procesandoGmail
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Icon(Icons.send_outlined),
          label: const Text('Enviar Gmail real'),
        ),
      ],
    );
  }

  Future<void> _guardarSimulado() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final vm = context.read<CorreoViewModel>();
    await vm.redactarCorreo(
      destinatario: _destinatarioController.text.trim(),
      asunto: _asuntoController.text.trim(),
      mensaje: _mensajeController.text.trim(),
    );

    if (!mounted) {
      return;
    }

    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Correo guardado en memoria')),
    );
  }

  Future<void> _enviarGmailReal() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final vm = context.read<CorreoViewModel>();
    final enviado = await vm.enviarCorreoReal(
      destinatario: _destinatarioController.text.trim(),
      asunto: _asuntoController.text.trim(),
      mensaje: _mensajeController.text.trim(),
    );

    if (!mounted) {
      return;
    }

    if (enviado) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Correo enviado con Gmail API')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(vm.mensajeError ?? 'No se pudo enviar el correo')),
      );
    }
  }
}
