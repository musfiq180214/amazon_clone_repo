import 'package:get/get.dart';
import '../models/product.dart';
import '../models/cart_item.dart';

class CartController extends GetxController {
  var cartItems = <CartItem>[].obs;

  void addToCart(Product product) {
    int index = cartItems.indexWhere((item) => item.product.id == product.id);
    if (index == -1) {
      cartItems.add(CartItem(product: product, quantity: 1));
    } else {
      cartItems[index].quantity++;
      cartItems.refresh();
    }
  }

  void removeFromCart(Product product) {
    cartItems.removeWhere((item) => item.product.id == product.id);
  }

  void increaseQuantity(Product product) {
    int index = cartItems.indexWhere((item) => item.product.id == product.id);
    if (index != -1) {
      cartItems[index].quantity++;
      cartItems.refresh();
    }
  }

  void decreaseQuantity(Product product) {
  int index = cartItems.indexWhere((item) => item.product.id == product.id);
  if (index != -1) {
    if (cartItems[index].quantity > 1) {
      cartItems[index].quantity--;
    } else {
      // quantity is 1 and user clicked minus => remove item
      cartItems.removeAt(index);
    }
    cartItems.refresh();
  }
}


  void clearCart() {
    cartItems.clear();
  }

  double get totalPrice => cartItems.fold(0, (sum, item) => sum + item.product.price * item.quantity);
}
