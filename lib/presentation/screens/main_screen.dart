import 'package:flutter/material.dart';

import 'billing/billing_screen.dart';
import 'calculator/calculator.dart';
import 'gemini_chat_screen.dart';
import 'sales_history/sales_history_screen.dart';
import 'settings_screen.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/custom_bottom_nav_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 2;

  final List<Widget> _screens = [
    const SalesHistory(),
    const BillingScreen(),
    const Calculator(),
    const GeminiChatScreen(),
    const SettingsScreen(),
  ];

  void _onItemTapped(int index) {
    if (_selectedIndex == index) return;
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedIndex,
        onTapped: _onItemTapped,
      ),
      appBar: CustomAppBar(selectedIndex: _selectedIndex),
      resizeToAvoidBottomInset: _selectedIndex == 0 ? false : null,
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
    );
  }
}
