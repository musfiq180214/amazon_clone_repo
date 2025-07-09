import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/cart_controller.dart';
import '../controllers/order_controller.dart';

class OrderSummaryScreen extends StatelessWidget {
  final cartController = Get.find<CartController>();
  final orderController = Get.find<OrderController>();

  @override
  Widget build(BuildContext context) {
    final items = cartController.cartItems;

    return Scaffold(
      appBar: AppBar(title: Text("Order Summary")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (_, index) {
                  final item = items[index];
                  return ListTile(
                    title: Text(item.product.title),
                    subtitle: Text("Qty: ${item.quantity}"),
                    trailing: Text("\$${(item.product.price * item.quantity).toStringAsFixed(2)}"),
                  );
                },
              ),
            ),
            Text(
              "Total: \$${cartController.totalPrice.toStringAsFixed(2)}",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text("Place Order"),
              onPressed: () {
                orderController.placeOrder(items);
                cartController.clearCart();
                Get.snackbar("Success", "Order placed successfully!");
                Get.back(); // return to cart or product list
              },
            ),
          ],
        ),
      ),
    );
  }
}
