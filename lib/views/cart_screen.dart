import 'package:amazon_clone/controllers/order_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/cart_controller.dart';

class CartScreen extends StatelessWidget {
  final CartController cartController = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cart')),
      body: Obx(() {
        final cartItems = cartController.cartItems;

        if (cartItems.isEmpty) {
          return Center(child: Text('Your cart is empty'));
        }

        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  final item = cartItems[index];
                  return ListTile(
                    leading: Image.network(item.product.image, width: 50, height: 50),
                    title: Text(item.product.title),
                    subtitle: Text('\$${item.product.price.toStringAsFixed(2)}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.remove),
                          onPressed: () => cartController.decreaseQuantity(item.product),
                        ),
                        Text('${item.quantity}'),
                        IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () => cartController.increaseQuantity(item.product),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () => cartController.removeFromCart(item.product),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Obx(() => Text(
                      '\$${cartController.totalPrice.toStringAsFixed(2)}',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    )),
                ],
              ),
            ),
            ElevatedButton(
  onPressed: () {
    final cartController = Get.find<CartController>();
    final orderController = Get.find<OrderController>();

    if (cartController.cartItems.isEmpty) {
      Get.snackbar('Empty Cart', 'Please add items before checkout');
      return;
    }

    // Place the order
    orderController.placeOrder(cartController.cartItems);

    // Clear cart after checkout
    cartController.clearCart();

    // Show confirmation
    Get.snackbar('Order Placed', 'Your order has been placed successfully');
  },
  child: Text('Checkout'),
),

          ],
        );
      }),
    );
  }
}
