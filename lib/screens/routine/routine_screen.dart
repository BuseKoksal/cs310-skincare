import 'package:flutter/material.dart';

import '../../data/routine_data.dart';
import '../../data/user_data.dart';
import '../../models/product.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_spacing.dart';
import '../../utils/app_text_styles.dart';
import '../../widgets/routine_product_card.dart';

class RoutineScreen extends StatefulWidget {
  final void Function()? onAddProduct;

  const RoutineScreen({super.key, this.onAddProduct});

  @override
  State<RoutineScreen> createState() => _RoutineScreenState();
}

class _RoutineScreenState extends State<RoutineScreen> {
  bool isMorning = true;

  String _greeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good morning';
    } else if (hour < 18) {
      return 'Good afternoon';
    }
    return 'Good evening';
  }

  void _removeProduct(Product product) {
    setState(() {
      if (isMorning) {
        RoutineData.morningProducts.remove(product);
      } else {
        RoutineData.eveningProducts.remove(product);
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${product.name} removed from your routine')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final products =
        isMorning ? RoutineData.morningProducts : RoutineData.eveningProducts;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    '${_greeting()}, ${UserData.name}!',
                    style: AppTextStyles.caption,
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  const Icon(Icons.wb_sunny_outlined, size: 14),
                ],
              ),
              const Text('My Routine', style: AppTextStyles.pageTitle),
              const SizedBox(height: AppSpacing.md),
              Row(
                children: [
                  Expanded(
                    child: _routineTab('Morning', Icons.wb_sunny_outlined, true),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: _routineTab('Evening', Icons.nightlight_outlined, false),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              Expanded(
                child: products.isEmpty
                    ? const Center(
                        child: Text(
                          'No products in this routine yet.',
                          style: AppTextStyles.bodyGray,
                          textAlign: TextAlign.center,
                        ),
                      )
                    : ListView.builder(
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          final product = products[index];
                          return RoutineProductCard(
                            product: product,
                            onRemove: () => _removeProduct(product),
                          );
                        },
                      ),
              ),
              const SizedBox(height: AppSpacing.sm),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: widget.onAddProduct,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppSpacing.radiusPill),
                    ),
                  ),
                  icon: const Icon(Icons.add),
                  label: const Text('Add Product', style: AppTextStyles.button),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _routineTab(String label, IconData icon, bool morning) {
    final selected = isMorning == morning;
    final color = selected ? AppColors.white : AppColors.textDark;

    return GestureDetector(
      onTap: () {
        setState(() {
          isMorning = morning;
        });
      },
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          color: selected ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(AppSpacing.radiusPill),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 16, color: color),
            const SizedBox(width: AppSpacing.xs),
            Text(label, style: AppTextStyles.button.copyWith(color: color)),
          ],
        ),
      ),
    );
  }
}
