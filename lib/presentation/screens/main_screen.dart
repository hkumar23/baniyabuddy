import 'package:baniyabuddy/presentation/screens/billing/billing_screen.dart';
import 'package:baniyabuddy/presentation/screens/calculator/calculator.dart';
import 'package:baniyabuddy/presentation/screens/gemini_chat_screen.dart';
import 'package:baniyabuddy/presentation/screens/sales_history/sales_history_screen.dart';
import 'package:baniyabuddy/presentation/screens/settings_screen.dart';
import 'package:baniyabuddy/presentation/widgets/custom_appbar.dart';
import 'package:baniyabuddy/presentation/widgets/custom_bottom_nav_bar.dart';
import 'package:flutter/material.dart';

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
