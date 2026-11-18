import '../models/product.dart';

class RoutineData {
  static List<Product> morningProducts = [
    const Product(
      id: 101,
      name: 'Hydrating Serum',
      brand: 'The Ordinary',
      category: 'Serum',
      skinType: 'All',
      description: 'A lightweight serum that keeps the skin hydrated.',
      imageUrl: 'https://placehold.co/200x200/png',
    ),
    const Product(
      id: 102,
      name: 'Gentle Cleanser',
      brand: 'Cetaphil',
      category: 'Cleanser',
      skinType: 'Dry',
      description: 'A mild cleanser for daily use.',
      imageUrl: 'https://placehold.co/200x200/png',
    ),
    const Product(
      id: 103,
      name: 'SPF 50 Sunscreen',
      brand: 'La Roche-Posay',
      category: 'Sunscreen',
      skinType: 'All',
      description: 'Daily sun protection for sensitive skin.',
      imageUrl: 'https://placehold.co/200x200/png',
    ),
  ];

  static List<Product> eveningProducts = [
    const Product(
      id: 102,
      name: 'Gentle Cleanser',
      brand: 'Cetaphil',
      category: 'Cleanser',
      skinType: 'Dry',
      description: 'A mild cleanser for daily use.',
      imageUrl: 'https://placehold.co/200x200/png',
    ),
    const Product(
      id: 104,
      name: 'Night Cream',
      brand: 'CeraVe',
      category: 'Moisturizer',
      skinType: 'Normal',
      description: 'A rich cream that repairs the skin overnight.',
      imageUrl: 'https://placehold.co/200x200/png',
    ),
  ];

  // returns false if the product is already in that routine
  static bool addProduct(Product product, bool isMorning) {
    final list = isMorning ? morningProducts : eveningProducts;
    for (final item in list) {
      if (item.id == product.id) {
        return false;
      }
    }
    list.add(product);
    return true;
  }
}
