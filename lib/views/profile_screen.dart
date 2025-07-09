import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class ProfileScreen extends StatelessWidget {
  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    final user = authController.loggedInUser.value;

    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: user == null
            ? Center(child: Text('No user info found'))
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Username: ${user.username}', style: TextStyle(fontSize: 18)),
                  SizedBox(height: 10),
                  Text('Email: ${user.email}', style: TextStyle(fontSize: 18)),
                  SizedBox(height: 20),
                  ElevatedButton.icon(
                    icon: Icon(Icons.logout),
                    label: Text('Logout'),
                    onPressed: () {
                      authController.logoutUser();
                      Get.offAllNamed('/login'); // Navigate to login screen
                    },
                  )
                ],
              ),
      ),
    );
  }
}
