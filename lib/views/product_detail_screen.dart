import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/cart_controller.dart';
import '../models/product.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;
  final CartController cartController = Get.find<CartController>();

  ProductDetailScreen({required this.product});

  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: Text(product.title)),
    body: SingleChildScrollView(   // <-- Add this wrapper
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(product.image, height: 250),
          SizedBox(height: 16),
          Text(product.title, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Text('\$${product.price.toStringAsFixed(2)}', style: TextStyle(fontSize: 20, color: Colors.green)),
          SizedBox(height: 16),
          Text(product.description),   // Long description scrolls properly now
          SizedBox(height: 24),
          Obx(() {
            final cartItem = cartController.cartItems.firstWhereOrNull(
              (item) => item.product.id == product.id,
            );

            final quantity = cartItem?.quantity ?? 0;

            if (quantity == 0) {
              return ElevatedButton(
                onPressed: () => cartController.addToCart(product),
                child: Text('Add to Cart'),
              );
            } else {
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: () => cartController.decreaseQuantity(product),
                  ),
                  Text('$quantity', style: TextStyle(fontSize: 18)),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () => cartController.increaseQuantity(product),
                  ),
                ],
              );
            }
          }),
        ],
      ),
    ),
  );
}
}
