import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/policy_entity.dart';
import '../viewmodels/policy_viewmodel.dart';
import 'edit_policy_view.dart';
import 'policy_card.dart';

class PolicyListView extends StatelessWidget {
  const PolicyListView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<PolicyViewModel>();

    if (viewModel.isLoading && viewModel.policies.isEmpty) {
      return const _LoadingState();
    }

    if (viewModel.errorMessage != null && viewModel.policies.isEmpty) {
      return _FullErrorState(
        message: viewModel.errorMessage!,
        onRetry: () => viewModel.loadPolicies(),
      );
    }

    if (viewModel.policies.isEmpty) {
      return RefreshIndicator(
        onRefresh: viewModel.loadPolicies,
        child: ListView(
          padding: const EdgeInsets.all(18),
          children: const [
            SizedBox(height: 90),
            _EmptyState(),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: viewModel.loadPolicies,
      child: ListView.builder(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        itemCount: viewModel.policies.length + (viewModel.errorMessage != null ? 1 : 0),
        itemBuilder: (context, index) {
          if (viewModel.errorMessage != null && index == 0) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _InlineErrorState(
                message: viewModel.errorMessage!,
                onRetry: () => viewModel.loadPolicies(),
              ),
            );
          }

          final realIndex = viewModel.errorMessage != null ? index - 1 : index;
          final policy = viewModel.policies[realIndex];
          return PolicyCard(
            policy: policy,
            onEdit: () => _openEditScreen(context, policy),
            onDelete: () => _confirmDelete(context, policy),
          );
        },
      ),
    );
  }

  void _openEditScreen(BuildContext context, PolicyEntity policy) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => EditPolicyView(policy: policy),
      ),
    );
  }

  Future<void> _confirmDelete(BuildContext context, PolicyEntity policy) async {
    final viewModel = context.read<PolicyViewModel>();
    final confirm = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
        title: const Text('Eliminar póliza'),
        content: Text('¿Deseas eliminar la póliza ${policy.codigo}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: const Color(0xFFBE123C)),
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );

    if (confirm != true || !context.mounted) return;

    final success = await viewModel.deletePolicy(policy.codigo);
    if (!context.mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(
          success
              ? 'Póliza eliminada correctamente'
              : viewModel.errorMessage ?? 'No se pudo eliminar la póliza',
        ),
      ),
    );
  }
}

class _LoadingState extends StatelessWidget {
  const _LoadingState();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text('Cargando pólizas...'),
            ],
          ),
        ),
      ),
    );
  }
}

class _FullErrorState extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _FullErrorState({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF1F2),
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: const Icon(Icons.cloud_off_rounded, size: 42, color: Color(0xFFBE123C)),
                ),
                const SizedBox(height: 16),
                const Text(
                  'No se pudo cargar la información',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(message, textAlign: TextAlign.center),
                const SizedBox(height: 18),
                FilledButton.icon(
                  onPressed: onRetry,
                  icon: const Icon(Icons.refresh_rounded),
                  label: const Text('Reintentar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _InlineErrorState extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _InlineErrorState({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFFFFF1F2),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            const Icon(Icons.warning_amber_rounded, color: Color(0xFFBE123C)),
            const SizedBox(width: 10),
            Expanded(child: Text(message)),
            TextButton(onPressed: onRetry, child: const Text('Reintentar')),
          ],
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(26),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFFEFF6FF),
                borderRadius: BorderRadius.circular(28),
              ),
              child: const Icon(Icons.assignment_late_outlined, size: 56, color: Color(0xFF1E3A8A)),
            ),
            const SizedBox(height: 18),
            const Text(
              'No existen pólizas registradas',
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.w900),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text(
              'Registra una nueva póliza desde la pestaña Registrar.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Color(0xFF64748B)),
            ),
          ],
        ),
      ),
    );
  }
}
