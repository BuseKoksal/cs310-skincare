import 'product_detail_screen.dart';
import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() =>
      _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final List<Product> products = [
    const Product(
      id: 1,
      name: 'Hydrating Cleanser',
      brand: 'CeraVe',
      category: 'Cleanser',
      skinType: 'Dry',
      description: 'A gentle hydrating facial cleanser.',
      imageUrl: 'https://placehold.co/200x200/png',
    ),
    const Product(
      id: 2,
      name: 'Niacinamide Serum',
      brand: 'The Ordinary',
      category: 'Serum',
      skinType: 'Oily',
      description: 'A serum for a simple skincare routine.',
      imageUrl: 'https://placehold.co/200x200/png',
    ),
    const Product(
      id: 3,
      name: 'Daily Moisturizer',
      brand: 'CeraVe',
      category: 'Moisturizer',
      skinType: 'Normal',
      description: 'A daily facial moisturizer.',
      imageUrl: 'https://placehold.co/200x200/png',
    ),
  ];

  String searchQuery = '';
  String selectedCategory = 'All';

  final List<String> categories = [
    'All',
    'Cleanser',
    'Serum',
    'Moisturizer',
  ];

  @override
  Widget build(BuildContext context) {
    final filteredProducts = products.where((product) {
      final matchesSearch =
          product.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
              product.brand.toLowerCase().contains(searchQuery.toLowerCase());

      final matchesCategory =
          selectedCategory == 'All' ||
              product.category == selectedCategory;

      return matchesSearch && matchesCategory;
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF8F7F0),
      appBar: AppBar(
        title: const Text('Products'),
        backgroundColor: const Color(0xFFF8F7F0),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Search products...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            ),
          ),


          SizedBox(
            height: 55,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: categories.map((category) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(category),
                    selected: selectedCategory == category,
                    selectedColor: const Color(0xFFD4E5CE),
                    onSelected: (_) {
                      setState(() {
                        selectedCategory = category;
                      });
                    },
                  ),
                );
              }).toList(),
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: filteredProducts.length,
              itemBuilder: (context, index) {
                final product = filteredProducts[index];

                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailScreen(
                            product: product,
                          ),
                        ),
                      );
                    },
                    leading: Image.network(
                      product.imageUrl,
                      width: 55,
                      height: 55,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(
                          Icons.spa,
                          size: 45,
                        );
                      },
                    ),
                    title: Text(product.name),
                    subtitle: Text(
                      '${product.brand} • ${product.category}',
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete_outline),
                      onPressed: () {
                        setState(() {
                          products.removeWhere(
                                (item) => item.id == product.id,
                          );
                        });

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('${product.name} removed'),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
