import 'package:flutter/material.dart';

class AddBillItemButton extends StatelessWidget {
  const AddBillItemButton({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Container(
      height: 50,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Colors.white12,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.add),
          const SizedBox(width: 7),
          Text(
            "Add Item",
            style: theme.textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}
