import 'package:flutter/material.dart';

import 'app bars/settings_app_bar.dart';
import 'app bars/calculator_app_bar.dart';
import 'app bars/billing_app_bar.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  final int selectedIndex;
  const CustomAppBar({
    super.key,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    if (selectedIndex == 1) {
      return const CalculatorAppBar();
    } else if (selectedIndex == 0) {
      return const BillingAppBar();
    } else if (selectedIndex == 4) {
      return const SettingsAppBar();
    }
    return const SizedBox.shrink();
  }
}
