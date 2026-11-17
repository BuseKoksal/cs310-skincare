
import 'package:flutter/material.dart';

import '../models/product.dart';
import '../utils/app_colors.dart';
import '../utils/app_spacing.dart';
import '../utils/app_text_styles.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        title: const Text(
          'Product Details',
          style: AppTextStyles.subtitle,
        ),
        backgroundColor: AppColors.background,
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // PRODUCT NETWORK IMAGE
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                    AppSpacing.radiusLarge,
                  ),
                  child: Image.network(
                    product.imageUrl,
                    height: 200,
                    width: 200,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 200,
                        width: 200,
                        color: AppColors.lightSage,
                        child: const Icon(
                          Icons.spa,
                          size: 100,
                          color: AppColors.primary,
                        ),
                      );
                    },
                  ),
                ),
              ),

              const SizedBox(height: AppSpacing.xl),

              // PRODUCT NAME
              Text(
                product.name,
                style: AppTextStyles.pageTitle.copyWith(
                  color: AppColors.primaryDark,
                ),
              ),

              const SizedBox(height: AppSpacing.sm),

              // BRAND
              Text(
                product.brand,
                style: AppTextStyles.subtitle.copyWith(
                  color: AppColors.textGray,
                ),
              ),

              const SizedBox(height: AppSpacing.lg),

              // CATEGORY
              const Text(
                'Category',
                style: AppTextStyles.sectionTitle,
              ),

              const SizedBox(height: AppSpacing.sm),

              Text(
                product.category,
                style: AppTextStyles.body,
              ),

              const SizedBox(height: AppSpacing.lg),

              // RECOMMENDED SKIN TYPE
              const Text(
                'Recommended Skin Type',
                style: AppTextStyles.sectionTitle,
              ),

              const SizedBox(height: AppSpacing.sm),

              Text(
                product.skinType,
                style: AppTextStyles.body,
              ),

              const SizedBox(height: AppSpacing.lg),

              // DESCRIPTION
              const Text(
                'Description',
                style: AppTextStyles.sectionTitle,
              ),

              const SizedBox(height: AppSpacing.sm),

              Text(
                product.description,
                style: AppTextStyles.body,
              ),

              const SizedBox(height: AppSpacing.xl),

              // ADD TO ROUTINE BUTTON
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.white,
                    padding: const EdgeInsets.symmetric(
                      vertical: AppSpacing.md,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        AppSpacing.radius,
                      ),
                    ),
                  ),

                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          '${product.name} added to routine!',
                        ),
                      ),
                    );
                  },

                  child: const Text(
                    'Add to Routine',
                    style: AppTextStyles.button,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
