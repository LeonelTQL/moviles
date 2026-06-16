import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodels/correo_viewmodel.dart';
import 'widgets/gmail_widget.dart';
import 'widgets/redactar_dialog.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<CorreoViewModel>(
      context,
      listen: false,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Prototipo de widget'),
        actions: [
          IconButton(
            tooltip: 'Leer Gmail real',
            onPressed: () => _sincronizarGmail(context),
            icon: const Icon(Icons.cloud_sync_outlined),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          child: Center(
            child: GmailWidget(
              onBuscarTap: () {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text('Buscar'),
                    content: const Text(
                      'Escribe en la barra de búsqueda para filtrar por asunto, remitente o destinatario.',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Entendido'),
                      ),
                    ],
                  ),
                );
              },
              onRedactarTap: () {
                showDialog(
                  context: context,
                  builder: (_) => const RedactarDialog(),
                );
              },
              onNoLeidosTap: () async {
                await vm.marcarTodosLeidos();

                if (!context.mounted) {
                  return;
                }

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Todos los correos marcados como leídos'),
                  ),
                );
              },
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await vm.recibirNuevoCorreo();

          if (!context.mounted) {
            return;
          }

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Llegó un correo simulado')),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text('Recibir'),
      ),
    );
  }

  Future<void> _sincronizarGmail(BuildContext context) async {
    final vm = context.read<CorreoViewModel>();
    final ok = await vm.sincronizarConGmailReal();

    if (!context.mounted) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          ok
              ? 'Correos reales cargados desde Gmail API'
              : vm.mensajeError ?? 'No se pudo conectar con Gmail API',
        ),
      ),
    );
  }
}
