import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';
import '../models/user.dart';

class AuthService {
  final _box = GetStorage();

  Future<User?> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('https://fakestoreapi.com/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username, 'password': password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final token = data['token'];
      _box.write('token', token);

      return User(id: 0, username: username, email: '', token: token);
    } else {
      throw Exception('Failed to login');
    }
  }

  void logout() {
    _box.remove('token');
  }

  String? get token => _box.read('token');
}
