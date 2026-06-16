import 'package:flutter/material.dart';

import '../../domain/entities/policy_entity.dart';
import '../../domain/usecases/create_policy_usecase.dart';
import '../../domain/usecases/delete_policy_usecase.dart';
import '../../domain/usecases/get_policies_usecase.dart';
import '../../domain/usecases/update_policy_usecase.dart';

class PolicyViewModel extends ChangeNotifier {
  final GetPoliciesUseCase getPoliciesUseCase;
  final CreatePolicyUseCase createPolicyUseCase;
  final UpdatePolicyUseCase updatePolicyUseCase;
  final DeletePolicyUseCase deletePolicyUseCase;

  PolicyViewModel({
    required this.getPoliciesUseCase,
    required this.createPolicyUseCase,
    required this.updatePolicyUseCase,
    required this.deletePolicyUseCase,
  }) {
    loadPolicies();
  }

  List<PolicyEntity> _policies = [];
  bool _isLoading = false;
  String? _errorMessage;
  int _selectedIndex = 0;

  List<PolicyEntity> get policies => _policies;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  int get selectedIndex => _selectedIndex;

  int get totalPolicies => _policies.length;

  double get totalInsuredValue {
    return _policies.fold(0, (sum, policy) => sum + policy.valorAsegurado);
  }

  PolicyEntity? get highestPolicy {
    if (_policies.isEmpty) return null;
    final ordered = [..._policies]..sort((a, b) => b.valorAsegurado.compareTo(a.valorAsegurado));
    return ordered.first;
  }

  void changeTab(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  Future<void> loadPolicies({bool showLoading = true}) async {
    if (showLoading) _setLoading(true);
    try {
      _policies = await getPoliciesUseCase();
      _errorMessage = null;
    } catch (error) {
      _errorMessage = _cleanError(error);
    } finally {
      if (showLoading) {
        _setLoading(false);
      } else {
        notifyListeners();
      }
    }
  }

  Future<bool> createPolicy(PolicyEntity policy) async {
    _setLoading(true);
    try {
      await createPolicyUseCase(policy);
      await loadPolicies(showLoading: false);
      _errorMessage = null;
      return true;
    } catch (error) {
      _errorMessage = _cleanError(error);
      notifyListeners();
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> updatePolicy(PolicyEntity policy) async {
    _setLoading(true);
    try {
      await updatePolicyUseCase(policy);
      await loadPolicies(showLoading: false);
      _errorMessage = null;
      return true;
    } catch (error) {
      _errorMessage = _cleanError(error);
      notifyListeners();
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> deletePolicy(String code) async {
    _setLoading(true);
    try {
      await deletePolicyUseCase(code);
      await loadPolicies(showLoading: false);
      _errorMessage = null;
      return true;
    } catch (error) {
      _errorMessage = _cleanError(error);
      notifyListeners();
      return false;
    } finally {
      _setLoading(false);
    }
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  String _cleanError(Object error) {
    final message = error.toString().replaceFirst('Exception: ', '').trim();
    return message.isEmpty ? 'Ocurrió un error inesperado' : message;
  }
}
