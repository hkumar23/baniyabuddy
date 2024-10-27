import 'package:baniyabuddy/presentation/widgets/billing%20components/add_billitem_dialog.dart';
import 'package:flutter/material.dart';

class AddItemButtonInvoice extends StatelessWidget {
  const AddItemButtonInvoice({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (context) {
              return const AddBillitemDialog();
            });
      },
      child: Container(
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
      ),
    );
  }
}
