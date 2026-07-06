import 'api_service.dart';
import 'storage_service.dart';

class AuthService {
  final ApiService _api = ApiService();

  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await _api.post('auth/login', body: {
      'email': email,
      'password': password,
    });

    final token = response['token'];
    final user = response['user'];

    if (token != null) {
      await StorageService.saveToken(token);
      await StorageService.saveUser(user);
    }

    return response;
  }

  Future<Map<String, dynamic>> register(Map<String, dynamic> data) async {
    final response = await _api.post('auth/register', body: data);

    final token = response['token'];
    final user = response['user'];

    if (token != null) {
      await StorageService.saveToken(token);
      await StorageService.saveUser(user);
    }

    return response;
  }

  Future<void> logout() async {
    await StorageService.clearAll();
  }

  bool get isLoggedIn => StorageService.getToken() != null;
}
