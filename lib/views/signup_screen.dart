import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/auth_service.dart';

class SignupScreen extends StatefulWidget {
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final usernameCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final authService = AuthService();

  bool isLoading = false;

  void signup() async {
    setState(() => isLoading = true);
    try {
      // FakeStoreAPI /users endpoint expects username, password, email
      // But FakeStoreAPI does not support real signup; we simulate it

      // Here you can implement a POST /users request if your backend supports it.
      // For now, just show success message for demo.

      Get.snackbar('Success', 'Signup simulated. Now login.');
      Get.back(); // go back to login screen
    } catch (e) {
      Get.snackbar('Error', 'Signup failed');
    }
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Signup')),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(controller: usernameCtrl, decoration: InputDecoration(labelText: 'Username')),
            TextField(controller: emailCtrl, decoration: InputDecoration(labelText: 'Email')),
            TextField(controller: passwordCtrl, decoration: InputDecoration(labelText: 'Password'), obscureText: true),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: isLoading ? null : signup,
              child: isLoading ? CircularProgressIndicator() : Text('Signup'),
            ),
          ],
        ),
      ),
    );
  }
}
