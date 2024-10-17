import 'package:flutter/material.dart';

import '../../constants/app_language.dart';
import '../../utils/app_methods.dart';

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
    if (selectedIndex == 2) {
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
      );
    } else if (selectedIndex == 1) {
      return AppBar(
        title: Text(
          AppLanguage.billing,
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .copyWith(fontWeight: FontWeight.w500),
        ),
      );
    }
    return const SizedBox.shrink();
  }
}
