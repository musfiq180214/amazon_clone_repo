import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/auth_service.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final usernameCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();

  final authService = AuthService();
  bool isLoading = false;

  void register() async {
    setState(() => isLoading = true);

    final data = {
      "email": emailCtrl.text,
      "username": usernameCtrl.text,
      "password": passwordCtrl.text,
      "name": {
        "firstname": "John",
        "lastname": "Doe"
      },
      "address": {
        "city": "Dhaka",
        "street": "Some Street",
        "number": 42,
        "zipcode": "1230",
        "geolocation": {"lat": "90.000", "long": "23.000"}
      },
      "phone": phoneCtrl.text
    };

    try {
      final success = await authService.register(data);
      if (success) {
        Get.snackbar('Success', 'Account created. Now use a valid demo user to login.');
        Get.off(() => LoginScreen());
      }
    } catch (e) {
      Get.snackbar('Error', 'Registration failed');
    }

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(controller: usernameCtrl, decoration: InputDecoration(labelText: 'Username')),
              TextField(controller: emailCtrl, decoration: InputDecoration(labelText: 'Email')),
              TextField(controller: phoneCtrl, decoration: InputDecoration(labelText: 'Phone')),
              TextField(controller: passwordCtrl, decoration: InputDecoration(labelText: 'Password'), obscureText: true),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: isLoading ? null : register,
                child: isLoading ? CircularProgressIndicator(color: Colors.white) : Text('Register'),
              ),
              TextButton(
                onPressed: () => Get.off(() => LoginScreen()),
                child: Text('Already have an account? Login'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
