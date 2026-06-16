import 'package:flutter/material.dart';

import '../../domain/entities/policy_entity.dart';

class PolicyCard extends StatelessWidget {
  final PolicyEntity policy;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const PolicyCard({
    super.key,
    required this.policy,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF1E3A8A), Color(0xFF0F766E)],
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      policy.codigo.isEmpty ? '?' : policy.codigo.substring(0, 1).toUpperCase(),
                      style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w900),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          policy.codigo,
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          policy.cliente,
                          style: const TextStyle(color: Color(0xFF64748B), fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                  PopupMenuButton<String>(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    onSelected: (value) {
                      if (value == 'edit') onEdit();
                      if (value == 'delete') onDelete();
                    },
                    itemBuilder: (_) => const [
                      PopupMenuItem(
                        value: 'edit',
                        child: Row(
                          children: [
                            Icon(Icons.edit_outlined),
                            SizedBox(width: 10),
                            Text('Editar'),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        value: 'delete',
                        child: Row(
                          children: [
                            Icon(Icons.delete_outline, color: Color(0xFFBE123C)),
                            SizedBox(width: 10),
                            Text('Eliminar'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Column(
                  children: [
                    _PolicyInfo(icon: Icons.security_rounded, label: 'Tipo', value: policy.tipoSeguro),
                    const Divider(height: 20),
                    _PolicyInfo(icon: Icons.calendar_month_rounded, label: 'Inicio', value: policy.fechaInicio),
                    const Divider(height: 20),
                    _PolicyInfo(icon: Icons.event_available_rounded, label: 'Vencimiento', value: policy.fechaVencimiento),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  const Text(
                    'Valor asegurado',
                    style: TextStyle(color: Color(0xFF64748B), fontWeight: FontWeight.w700),
                  ),
                  const Spacer(),
                  Text(
                    '\$${policy.valorAsegurado.toStringAsFixed(2)}',
                    style: const TextStyle(
                      color: Color(0xFF0F766E),
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PolicyInfo extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _PolicyInfo({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20, color: const Color(0xFF1E3A8A)),
        const SizedBox(width: 10),
        Text(
          label,
          style: const TextStyle(color: Color(0xFF64748B), fontWeight: FontWeight.w700),
        ),
        const Spacer(),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: const TextStyle(fontWeight: FontWeight.w800),
          ),
        ),
      ],
    );
  }
}
