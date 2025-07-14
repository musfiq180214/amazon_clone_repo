// controllers/order_controller.dart
import 'package:get/get.dart';
import '../models/cart_item.dart';

class OrderController extends GetxController {
  final orders = <List<CartItem>>[].obs;

  void placeOrder(List<CartItem> cartItems) {
    if (cartItems.isNotEmpty) {
      orders.add(List<CartItem>.from(cartItems));
    }
  }
}
