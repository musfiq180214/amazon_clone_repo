import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'login_screen.dart';
import 'signup_screen.dart';

class EntryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Welcome')),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(40),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () => Get.to(() => LoginScreen()),
                child: Text('Login'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => Get.to(() => SignupScreen()),
                child: Text('Signup'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
