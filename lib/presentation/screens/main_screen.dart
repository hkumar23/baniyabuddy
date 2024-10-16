import 'package:baniyabuddy/constants/app_language.dart';
import 'package:baniyabuddy/presentation/screens/billing_screen.dart';
import 'package:baniyabuddy/presentation/screens/calculator/calculator.dart';
import 'package:baniyabuddy/presentation/screens/gemini_chat_screen.dart';
import 'package:baniyabuddy/presentation/screens/sales_history/sales_history_screen.dart';
import 'package:baniyabuddy/presentation/screens/settings_screen.dart';
import 'package:baniyabuddy/presentation/widgets/custom_bottom_nav_bar.dart';
import 'package:baniyabuddy/utils/app_methods.dart';
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
      appBar: _selectedIndex == 2
          ? AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return const SalesHistory();
                      },
                    ),
                  );
                },
                icon: const Icon(Icons.history_rounded),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    AppMethods.logoutWithDialog(context);
                  },
                  icon: const Icon(
                    Icons.logout,
                    // color: Colors.red,
                  ),
                ),
              ],
              forceMaterialTransparency: true,
              title: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Image.asset(
                  //   "assets/logo/baniya_buddy_logo.png",
                  //   fit: BoxFit.contain,
                  //   height: 32,
                  // ),
                  Text(
                    AppLanguage.appName,
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall!
                        .copyWith(fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              centerTitle: true,
              // backgroundColor: Colors.grey.shade300,
            )
          : null,
      resizeToAvoidBottomInset: _selectedIndex == 0 ? false : null,
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
    );
  }
}
