import 'package:flutter/material.dart';

import 'calc%20components/app%20bars/calculator_app_bar.dart';
import 'calc components/app bars/billing_app_bar.dart';

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
      return CalculatorAppBar();
    } else if (selectedIndex == 0) {
      return BillingAppBar();
    }
    return const SizedBox.shrink();
  }
}

