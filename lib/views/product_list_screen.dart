import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/product.dart';
import '../services/product_service.dart';
import 'product_detail_screen.dart';
import 'cart_screen.dart';
import 'profile_screen.dart';

class ProductListScreen extends StatefulWidget {
  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final ProductService productService = ProductService();
  List<Product> products = [];
  List<String> categories = [];
  String? selectedCategory;

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadCategoriesAndProducts();
  }

  Future<void> loadCategoriesAndProducts() async {
    try {
      categories = await productService.fetchCategories();
      products = await productService.fetchProducts();
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print('Error loading products: $e');
    }
  }

  Future<void> filterByCategory(String category) async {
    setState(() => isLoading = true);
    final filteredProducts = await productService.fetchProductsByCategory(category);
    setState(() {
      selectedCategory = category;
      products = filteredProducts;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Amazon'),
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            tooltip: 'Profile',
            onPressed: () {
              Get.to(() => ProfileScreen());
            },
          ),
          IconButton(
            icon: Icon(Icons.shopping_cart),
            tooltip: 'Cart',
            onPressed: () {
              Get.to(() => CartScreen());
            },
          ),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                // Horizontal category selector
                Container(
                  height: 50,
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      categoryButton('All'),
                      ...categories.map((cat) => categoryButton(cat)).toList(),
                    ],
                  ),
                ),

                // Product list
                Expanded(
                  child: products.isEmpty
                      ? Center(child: Text('No products found'))
                      : ListView.builder(
                          itemCount: products.length,
                          itemBuilder: (context, index) {
                            final p = products[index];
                            return ListTile(
                              leading: Image.network(p.image, width: 50, height: 50),
                              title: Text(p.title),
                              subtitle: Text('\$${p.price.toStringAsFixed(2)}'),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (_) => ProductDetailScreen(product: p)),
                                );
                              },
                            );
                          },
                        ),
                ),
              ],
            ),
    );
  }

  Widget categoryButton(String category) {
    final isSelected = selectedCategory == category || (category == 'All' && selectedCategory == null);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected ? Colors.blue : Colors.grey[300],
          foregroundColor: isSelected ? Colors.white : Colors.black,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
        onPressed: () {
          if (category == 'All') {
            loadCategoriesAndProducts();
            setState(() => selectedCategory = null);
          } else {
            filterByCategory(category);
          }
        },
        child: Text(category),
      ),
    );
  }
}
