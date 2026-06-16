import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodels/policy_viewmodel.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<PolicyViewModel>();
    final highestPolicy = viewModel.highestPolicy;

    return RefreshIndicator(
      onRefresh: viewModel.loadPolicies,
      child: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF1E3A8A), Color(0xFF0F766E)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(26),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF1E3A8A).withOpacity(0.22),
                  blurRadius: 24,
                  offset: const Offset(0, 12),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.16),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: const Text(
                    'Gestión de seguros',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Control de pólizas rápido, claro y ordenado',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.w900,
                    height: 1.12,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Consulta, registra y actualiza la información principal de cada cliente.',
                  style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 15),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          if (viewModel.isLoading) ...[
            const LinearProgressIndicator(minHeight: 6),
            const SizedBox(height: 14),
          ],
          if (viewModel.errorMessage != null) ...[
            _ErrorPanel(
              message: viewModel.errorMessage!,
              onRetry: () => viewModel.loadPolicies(),
            ),
            const SizedBox(height: 14),
          ],
          Row(
            children: [
              Expanded(
                child: _MetricCard(
                  icon: Icons.assignment_rounded,
                  title: 'Pólizas',
                  value: '${viewModel.totalPolicies}',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _MetricCard(
                  icon: Icons.savings_rounded,
                  title: 'Total asegurado',
                  value: '\$${viewModel.totalInsuredValue.toStringAsFixed(2)}',
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEFF6FF),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Icon(Icons.workspace_premium_rounded, color: Color(0xFF1E3A8A)),
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Text(
                          'Póliza con mayor valor',
                          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w900),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  if (highestPolicy == null)
                    const Text('Todavía no hay pólizas registradas.')
                  else ...[
                    Text(
                      highestPolicy.cliente,
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                    ),
                    const SizedBox(height: 5),
                    Text('${highestPolicy.codigo} · ${highestPolicy.tipoSeguro}'),
                    const SizedBox(height: 10),
                    Text(
                      '\$${highestPolicy.valorAsegurado.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF0F766E),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _MetricCard({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFFEFF6FF),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(icon, color: const Color(0xFF1E3A8A)),
            ),
            const SizedBox(height: 14),
            Text(
              value,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 4),
            Text(title, style: const TextStyle(color: Color(0xFF64748B))),
          ],
        ),
      ),
    );
  }
}

class _ErrorPanel extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorPanel({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFFFFF1F2),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            const Icon(Icons.wifi_off_rounded, color: Color(0xFFBE123C)),
            const SizedBox(width: 12),
            Expanded(child: Text(message)),
            TextButton(onPressed: onRetry, child: const Text('Reintentar')),
          ],
        ),
      ),
    );
  }
}
