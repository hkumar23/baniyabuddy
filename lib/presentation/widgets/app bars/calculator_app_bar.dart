import 'package:baniyabuddy/constants/app_language.dart';
import 'package:baniyabuddy/presentation/screens/sales_history/sales_history_screen.dart';
import 'package:baniyabuddy/utils/app_methods.dart';
import 'package:flutter/material.dart';

class CalculatorAppBar extends StatelessWidget {
  const CalculatorAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // leading: IconButton(
      //   onPressed: () {
      //     Navigator.of(context).push(
      //       MaterialPageRoute(
      //         builder: (context) {
      //           return const SalesHistory();
      //         },
      //       ),
      //     );
      //   },
      //   icon: const Icon(Icons.history_rounded),
      // ),

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
    );
  }
}
