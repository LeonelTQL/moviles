import '../../domain/entities/app_user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasource/local/session_local_datasource.dart';
import '../datasource/remote/api_client.dart';
import '../models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final ApiClient apiClient;
  final SessionLocalDatasource session;

  AuthRepositoryImpl({required this.apiClient, required this.session});

  @override
  Future<AppUser> login(String email, String password) async {
    final json = await apiClient.post('/auth/login', {'email': email, 'password': password});
    final user = UserModel.fromJson(json['user'] as Map<String, dynamic>);
    await session.saveSession(json['token'].toString(), user);
    return user;
  }

  @override
  Future<AppUser> register({required String name, required String email, required String password, required String phone, required String role}) async {
    final json = await apiClient.post('/auth/register', {
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,
      'role': role,
    });
    final user = UserModel.fromJson(json['user'] as Map<String, dynamic>);
    await session.saveSession(json['token'].toString(), user);
    return user;
  }

  @override
  Future<AppUser?> currentUser() => session.getUser();

  @override
  Future<void> logout() => session.clear();
}
