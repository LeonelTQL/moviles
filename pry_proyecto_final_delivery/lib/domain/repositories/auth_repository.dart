import '../entities/app_user.dart';

abstract class AuthRepository {
  Future<AppUser> login(String email, String password);
  Future<AppUser> register({required String name, required String email, required String password, required String phone, required String role});
  Future<AppUser?> currentUser();
  Future<void> logout();
}
