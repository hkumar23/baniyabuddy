import 'package:flutter/material.dart';

import 'filter_item.dart';

class FiltersRow extends StatelessWidget {
  const FiltersRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Row(
        children: [
          FilterItem(title: "All"),
          FilterItem(title: "UPI"),
          FilterItem(title: "Cash"),
          FilterItem(title: "Udhaar"),
        ],
      ),
    );
  }
}
