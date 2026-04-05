import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final _storage = const FlutterSecureStorage();
  //save email
  Future<void> saveEmail(String email) async {
    await _storage.write(key: 'email', value: email);
  }

  //save password
  Future<void> savePassword(String password) async {
    await _storage.write(key: 'password', value: password);
  }

  //read email
  Future<String?> getEmail(String email) async {
    return await _storage.read(key: 'email');
  }

  //read password
  Future<String?> getPassword(String password) async {
    return await _storage.read(key: 'password');
  }

  // Save Token
  Future<void> persistToken(String token) async {
    await _storage.write(key: 'jwt_token', value: token);
  }

  // Read Token
  Future<String?> getToken() async {
    return await _storage.read(key: 'jwt_token');
  }

  // Delete Token
  Future<void> deleteToken() async {
    await _storage.delete(key: 'jwt_token');
  }

  // Mock API Call for Login/Register
  Future<String> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 2)); // Simulate network
    return "mock_jwt_token_12345";
  }
}
