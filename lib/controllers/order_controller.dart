import 'package:get/get.dart';
import '../models/cart_item.dart';

class OrderController extends GetxController {
  var orderHistory = <List<CartItem>>[].obs;

  void placeOrder(List<CartItem> items) {
    orderHistory.add(List.from(items));
  }
  
}
