import 'package:amazon_clone/views/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/auth_service.dart';
import '../controllers/auth_controller.dart';
import 'product_list_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final usernameCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final authService = AuthService();
  final authController = Get.find<AuthController>();

  bool isLoading = false;

  void login() async {
    setState(() => isLoading = true);
    try {
      final user = await authController.login(usernameCtrl.text, passwordCtrl.text);
if (user != null) {
  Get.snackbar('Success', 'Logged in as ${user.username}');
  Get.offAll(() => ProductListScreen());
} else {
  Get.snackbar('Error', 'Login failed');
}

    } catch (e) {
      Get.snackbar('Error', 'Login failed');
    }
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: usernameCtrl,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: passwordCtrl,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: isLoading ? null : login,
              child: isLoading
                  ? CircularProgressIndicator(color: Colors.white)
                  : Text('Login'),
            ),

            TextButton(
  onPressed: () => Get.to(() => RegisterScreen()),
  child: Text('Don\'t have an account? Register'),
  )
          ],
        ),
      ),
    );
  }
}
