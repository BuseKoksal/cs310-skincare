# Skincare Routine App

## Project Overview

Skincare Routine App is a Flutter-based mobile application designed to make skincare easier and more personalized. It helps users find skincare products that match their skin type and concerns while making it easier to build and maintain a daily skincare routine.

Users can explore different skincare products, learn about their ingredients, and create their own morning and evening routines. The app also includes a skin diary where users can record their daily skin condition and track changes over time.

Our goal is to make skincare more organized and accessible, especially for people who are unsure which products to choose or how to build a suitable routine.

## Main Features

- **Skin Profile:** Select skin type and skin concerns to find suitable products.
- **Product Browsing:** Search and filter skincare products by category and price.
- **Product Details:** View product information, including brand, ingredients, and price.
- **Routine Builder:** Create and manage morning and evening skincare routines.
- **Skin Diary:** Track daily skin condition with ratings and notes.

## Technologies

- Flutter & Dart
- Local database for user data
- Skincare product dataset

## Group Members

Group Number: 11

- Buse Köksal – 34281
- Dença Anna Kuyumcu – 32016
- Melis Tunar – 33987

## How to Run

**Flutter version used:** Flutter 3.38.x (Dart 3.10.x) <!-- replace with the output of `flutter --version` -->

1. Install Flutter: https://docs.flutter.dev/get-started/install
2. Clone the repository:
   ```bash
   git clone https://github.com/BuseKoksal/cs310-skincare.git
   cd cs310-skincare
   ```
3. Get the packages:
   ```bash
   flutter pub get
   ```
4. Start an Android emulator or iOS simulator, then run:
   ```bash
   flutter run
   ```

Network images need an internet connection. Placeholder data is used in this step; Firebase will be added in Step 3.

## Project Structure

```
lib/
├── main.dart        # app entry point and named routes
├── data/            # placeholder data (routine, diary, user)
├── models/          # Product, DiaryEntry
├── screens/         # all screens
├── utils/           # shared colors, text styles, spacing, theme, date helper
└── widgets/         # reusable widgets (PrimaryButton, AppTextField, cards, back button)
assets/
├── fonts/           # Poppins (custom font)
└── images/          # local images
```
