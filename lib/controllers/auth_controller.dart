import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../models/user.dart';
import '../services/auth_service.dart';

class AuthController extends GetxController {
  var loggedInUser = Rxn<User>();
  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    _loadUserFromStorage();
  }

  void _loadUserFromStorage() {
    final userJson = box.read('user');
    if (userJson != null) {
      loggedInUser.value = User.fromJson(Map<String, dynamic>.from(userJson));
    }
  }

  Future<User?> login(String username, String password) async {
    // Your existing AuthService login code here
    final user = await AuthService().login(username, password);
    if (user != null) {
      loggedInUser.value = user;
      box.write('user', {
        'id': user.id,
        'username': user.username,
        'email': user.email,
        'token': user.token,
      });
    }
    return user;
  }

  void logoutUser() {
    loggedInUser.value = null;
    box.remove('user');
  }
}
