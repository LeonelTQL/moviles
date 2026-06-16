import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodels/policy_viewmodel.dart';
import 'dashboard_view.dart';
import 'policy_form_view.dart';
import 'policy_list_view.dart';

class MainNavigationView extends StatelessWidget {
  const MainNavigationView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<PolicyViewModel>();

    final pages = [
      const DashboardView(),
      const PolicyListView(),
      const PolicyFormView(),
    ];

    final titles = ['Inicio', 'Pólizas registradas', 'Registrar póliza'];

    return Scaffold(
      appBar: AppBar(
        title: Text(titles[viewModel.selectedIndex]),
        actions: [
          IconButton(
            tooltip: 'Actualizar',
            onPressed: viewModel.isLoading ? null : () => viewModel.loadPolicies(),
            icon: const Icon(Icons.refresh_rounded),
          ),
        ],
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        child: pages[viewModel.selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: viewModel.selectedIndex,
        onTap: viewModel.changeTab,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.space_dashboard_outlined),
            activeIcon: Icon(Icons.space_dashboard_rounded),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment_outlined),
            activeIcon: Icon(Icons.assignment_rounded),
            label: 'Pólizas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline_rounded),
            activeIcon: Icon(Icons.add_circle_rounded),
            label: 'Registrar',
          ),
        ],
      ),
    );
  }
}
