import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import 'diary/diary_screen.dart';
import 'home/home_screen.dart';
import 'product_list_screen.dart';
import 'routine/routine_screen.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _currentIndex = 0;

  void _changeTab(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      HomeScreen(onNavigate: _changeTab),
      const ProductListScreen(),
      RoutineScreen(onAddProduct: () => _changeTab(1)),
      const DiaryScreen(),
    ];

    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _changeTab,
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.sandBeige,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textGray,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.manage_search), label: 'Products'),
          BottomNavigationBarItem(icon: Icon(Icons.wb_sunny_outlined), label: 'Routine'),
          BottomNavigationBarItem(icon: Icon(Icons.edit_note), label: 'Diary'),
        ],
      ),
    );
  }
}
