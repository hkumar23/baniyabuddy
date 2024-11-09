import 'package:flutter/material.dart';

import '../../../constants/app_language.dart';

class BillingAppBar extends StatelessWidget {
  const BillingAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
}
