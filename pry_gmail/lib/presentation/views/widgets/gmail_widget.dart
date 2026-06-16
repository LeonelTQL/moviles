import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../domain/entities/correo_entity.dart';
import '../../../themes/index.dart';
import '../../viewmodels/correo_viewmodel.dart';

class GmailWidget extends StatelessWidget {
  final VoidCallback onBuscarTap;
  final VoidCallback onRedactarTap;
  final VoidCallback onNoLeidosTap;

  const GmailWidget({
    super.key,
    required this.onBuscarTap,
    required this.onRedactarTap,
    required this.onNoLeidosTap,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<CorreoViewModel>(
      builder: (context, vm, _) {
        return ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 520),
          child: Card(
            margin: EdgeInsets.zero,
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                children: [
                  _HeaderGmail(
                    noLeidos: vm.noLeidos,
                    procesandoGmail: vm.procesandoGmail,
                    onNoLeidosTap: onNoLeidosTap,
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    onChanged: vm.actualizarBusqueda,
                    decoration: InputDecoration(
                      hintText: 'Buscar por asunto, remitente o destinatario',
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: IconButton(
                        onPressed: onBuscarTap,
                        icon: const Icon(Icons.info_outline),
                        tooltip: 'Ayuda de búsqueda',
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: onRedactarTap,
                          icon: const Icon(Icons.edit_outlined),
                          label: const Text('Redactar'),
                        ),
                      ),
                      const SizedBox(width: 10),
                      _MiniAccion(
                        icon: Icons.mark_email_read_outlined,
                        label: 'Leídos',
                        onTap: onNoLeidosTap,
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  if (vm.mensajeError != null)
                    _MensajeError(mensaje: vm.mensajeError!),
                  if (vm.cargando)
                    const Expanded(
                      child: Center(child: CircularProgressIndicator()),
                    )
                  else
                    Expanded(
                      child: vm.correosFiltrados.isEmpty
                          ? const _EstadoVacio()
                          : ListView.separated(
                              itemCount: vm.correosFiltrados.length,
                              separatorBuilder: (_, __) => const Divider(height: 1),
                              itemBuilder: (context, index) {
                                final correo = vm.correosFiltrados[index];
                                return _CorreoItem(correo: correo);
                              },
                            ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _HeaderGmail extends StatelessWidget {
  final int noLeidos;
  final bool procesandoGmail;
  final VoidCallback onNoLeidosTap;

  const _HeaderGmail({
    required this.noLeidos,
    required this.procesandoGmail,
    required this.onNoLeidosTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            color: EsquemaColor.gmailRojo.withOpacity(0.12),
            borderRadius: BorderRadius.circular(18),
          ),
          child: const Icon(
            Icons.mark_email_unread_outlined,
            color: EsquemaColor.gmailRojo,
            size: 29,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Gmail Widget',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              Text(
                procesandoGmail ? 'Conectando con Gmail real...' : 'Prototipo funcional con Provider',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
        InkWell(
          onTap: onNoLeidosTap,
          borderRadius: BorderRadius.circular(18),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: noLeidos > 0 ? EsquemaColor.gmailRojo : EsquemaColor.gmailVerde,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Column(
              children: [
                Text(
                  '$noLeidos',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const Text(
                  'no leídos',
                  style: TextStyle(color: Colors.white, fontSize: 11),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _MiniAccion extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _MiniAccion({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
        decoration: BoxDecoration(
          color: const Color(0xFFF9FAFB),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: EsquemaColor.borde),
        ),
        child: Row(
          children: [
            Icon(icon, size: 19, color: EsquemaColor.gmailAzul),
            const SizedBox(width: 6),
            Text(label, style: Theme.of(context).textTheme.labelLarge),
          ],
        ),
      ),
    );
  }
}

class _CorreoItem extends StatelessWidget {
  final CorreoEntity correo;

  const _CorreoItem({required this.correo});

  @override
  Widget build(BuildContext context) {
    final vm = context.read<CorreoViewModel>();

    return InkWell(
      onTap: () => vm.marcarComoLeido(correo),
      borderRadius: BorderRadius.circular(18),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 22,
              backgroundColor: correo.enviado
                  ? EsquemaColor.gmailAzul.withOpacity(0.12)
                  : EsquemaColor.gmailRojo.withOpacity(0.12),
              child: Icon(
                correo.enviado ? Icons.send_outlined : Icons.person_outline,
                color: correo.enviado ? EsquemaColor.gmailAzul : EsquemaColor.gmailRojo,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          correo.enviado ? 'Para: ${correo.destinatario}' : correo.remitente,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: correo.leido ? FontWeight.w600 : FontWeight.w900,
                            color: EsquemaColor.textoPrincipal,
                          ),
                        ),
                      ),
                      Text(
                        _formatearHora(correo.fecha),
                        style: const TextStyle(
                          fontSize: 11,
                          color: EsquemaColor.textoSecundario,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    correo.asunto,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: correo.leido ? FontWeight.w500 : FontWeight.w800,
                      color: EsquemaColor.textoPrincipal,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    correo.mensaje,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            if (!correo.leido)
              Container(
                width: 10,
                height: 10,
                margin: const EdgeInsets.only(top: 8),
                decoration: const BoxDecoration(
                  color: EsquemaColor.gmailRojo,
                  shape: BoxShape.circle,
                ),
              ),
          ],
        ),
      ),
    );
  }

  String _formatearHora(DateTime fecha) {
    final hora = fecha.hour.toString().padLeft(2, '0');
    final minuto = fecha.minute.toString().padLeft(2, '0');
    return '$hora:$minuto';
  }
}

class _MensajeError extends StatelessWidget {
  final String mensaje;

  const _MensajeError({required this.mensaje});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: EsquemaColor.gmailRojo.withOpacity(0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: EsquemaColor.gmailRojo.withOpacity(0.18)),
      ),
      child: Text(
        mensaje,
        style: const TextStyle(color: EsquemaColor.gmailRojo, fontSize: 12),
      ),
    );
  }
}

class _EstadoVacio extends StatelessWidget {
  const _EstadoVacio();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.inbox_outlined,
            size: 60,
            color: EsquemaColor.textoSecundario.withOpacity(0.55),
          ),
          const SizedBox(height: 10),
          Text(
            'No hay correos para mostrar',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 4),
          Text(
            'Prueba cambiando la búsqueda o creando uno nuevo.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
