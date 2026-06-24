import 'package:flutter/material.dart';
import '../../domain/entities/app_user.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthRepository repository;
  AuthViewModel(this.repository);

  AppUser? user;
  bool loading = false;
  String? error;

  Future<void> loadSession() async {
    user = await repository.currentUser();
    notifyListeners();
  }

  Future<bool> login(String email, String password) async {
    return _run(() async {
      user = await repository.login(email.trim(), password);
    });
  }

  Future<bool> register({required String name, required String email, required String password, required String phone, required String role}) async {
    return _run(() async {
      user = await repository.register(name: name.trim(), email: email.trim(), password: password, phone: phone.trim(), role: role);
    });
  }

  Future<void> logout() async {
    await repository.logout();
    user = null;
    notifyListeners();
  }

  Future<bool> _run(Future<void> Function() action) async {
    loading = true;
    error = null;
    notifyListeners();
    try {
      await action();
      loading = false;
      notifyListeners();
      return true;
    } catch (e) {
      error = e.toString();
      loading = false;
      notifyListeners();
      return false;
    }
  }
}
