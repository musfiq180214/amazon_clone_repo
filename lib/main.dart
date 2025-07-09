import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'controllers/cart_controller.dart';
import 'controllers/auth_controller.dart';
import 'controllers/order_controller.dart';

import 'views/login_screen.dart';
import 'views/product_list_screen.dart';
import 'views/profile_screen.dart';
import 'views/entry_screen.dart';


/*
1. Created models for User, Product, CartItem, etc.
2. Created AuthService and ProductService to fetch data from the FakeStoreAPI(https://fakestoreapi.com/).
3. Used GetStorage to persist data like authentication token locally.
4. Created GetX controllers for Auth, Cart, and Order management.
5. Registered services and controllers as GetX dependencies (using Get.put).
6. Built Flutter views/screens for Login, Product List, Product Detail, Cart, Profile, and Entry Screen.
7. Implemented user authentication with login and logout, storing user/token info in GetStorage.
8. Used GetX's reactive state management (Obx) to update UI based on controller state changes.
9. Implemented navigation with GetX (Get.to, Get.offAll, etc.).
10. Developed a simple cart system with add, remove, quantity update, and clear cart functionalities.
11. Made Product Detail screen interactive with add/remove cart and quantity controls.
12. Displayed user info and logout option in Profile screen.
13. Used PopupMenu and dropdowns for category filtering and product list updates.
14. Handled edge cases like empty lists, loading states, and error states.
15. Ensured UI responsiveness and scrolling for long content.
*/

/*
username: mor_2314
password: 83r5^_
*/



void main() async {
  await GetStorage.init();
  Get.put(AuthController()); // Put AuthController here to initialize
  Get.put(CartController());  // Register CartController globally
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Obx(() {
        return authController.loggedInUser.value == null
            ? LoginScreen()
            : ProductListScreen();
      }),
    );
  }
}

