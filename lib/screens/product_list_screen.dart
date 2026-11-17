
import 'package:flutter/material.dart';

import '../models/product.dart';
import '../utils/app_colors.dart';
import '../utils/app_spacing.dart';
import '../utils/app_text_styles.dart';
import 'product_detail_screen.dart';

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
      final query = searchQuery.trim().toLowerCase();

      final matchesSearch =
          product.name.toLowerCase().contains(query) ||
              product.brand.toLowerCase().contains(query);

      final matchesCategory =
          selectedCategory == 'All' ||
              product.category == selectedCategory;

      return matchesSearch && matchesCategory;
    }).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'Products',
          style: AppTextStyles.subtitle,
        ),
        backgroundColor: AppColors.background,
      ),
      body: Column(
        children: [
          // SEARCH BAR
          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: TextField(
              style: AppTextStyles.body,
              decoration: InputDecoration(
                hintText: 'Search products...',
                hintStyle: AppTextStyles.bodyGray,
                prefixIcon: const Icon(
                  Icons.search,
                  color: AppColors.primary,
                ),
                filled: true,
                fillColor: AppColors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    AppSpacing.radius,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    AppSpacing.radius,
                  ),
                  borderSide: const BorderSide(
                    color: AppColors.border,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    AppSpacing.radius,
                  ),
                  borderSide: const BorderSide(
                    color: AppColors.primary,
                    width: 2,
                  ),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            ),
          ),

          // CATEGORY FILTERS
          SizedBox(
            height: 55,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
              ),
              children: categories.map((category) {
                return Padding(
                  padding: const EdgeInsets.only(
                    right: AppSpacing.sm,
                  ),
                  child: ChoiceChip(
                    label: Text(category),
                    selected: selectedCategory == category,
                    selectedColor: AppColors.sageSelected,
                    backgroundColor: AppColors.white,
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

          // PRODUCT CARDS
          Expanded(
            child: filteredProducts.isEmpty
                ? Center(
              child: Text(
                'No products found.',
                style: AppTextStyles.bodyGray,
              ),
            )
                : ListView.builder(
              itemCount: filteredProducts.length,
              itemBuilder: (context, index) {
                final product = filteredProducts[index];

                return Card(
                  color: AppColors.white,
                  margin: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: AppSpacing.sm,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      AppSpacing.radiusLarge,
                    ),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(
                      AppSpacing.sm,
                    ),

                    // OPEN PRODUCT DETAIL
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ProductDetailScreen(
                                product: product,
                              ),
                        ),
                      );
                    },

                    // NETWORK IMAGE
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(
                        AppSpacing.radiusSmall,
                      ),
                      child: Image.network(
                        product.imageUrl,
                        width: 55,
                        height: 55,
                        fit: BoxFit.cover,
                        errorBuilder:
                            (context, error, stackTrace) {
                          return const SizedBox(
                            width: 55,
                            height: 55,
                            child: Icon(
                              Icons.spa,
                              color: AppColors.primary,
                              size: 35,
                            ),
                          );
                        },
                      ),
                    ),

                    title: Text(
                      product.name,
                      style: AppTextStyles.cardTitle,
                    ),
                    subtitle: Text(
                      '${product.brand} • ${product.category}',
                      style: AppTextStyles.bodyGray,
                    ),

                    // REMOVE ACTION
                    trailing: IconButton(
                      icon: const Icon(
                        Icons.delete_outline,
                        color: AppColors.primaryDark,
                      ),
                      onPressed: () {
                        setState(() {
                          products.removeWhere(
                                (item) =>
                            item.id == product.id,
                          );
                        });

                        ScaffoldMessenger.of(context)
                            .showSnackBar(
                          SnackBar(
                            content: Text(
                              '${product.name} removed',
                            ),
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
