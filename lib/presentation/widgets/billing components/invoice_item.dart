import 'package:baniyabuddy/presentation/widgets/billing%20components/invoice_details_bottomsheet.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InvoiceItem extends StatelessWidget {
  InvoiceItem({super.key});
  final List<Map<String, dynamic>> items = [
    {
      'item': 'Product A',
      'quantity': 2,
      'unitPrice': 500,
      'tax': 18,
      'discount': 10,
      'totalPrice': 900
    },
    {
      'item': 'Product B',
      'quantity': 1,
      'unitPrice': 1200,
      'tax': 18,
      'discount': 5,
      'totalPrice': 1140
    },
    {
      'item': 'Product C',
      'quantity': 1,
      'unitPrice': 1000,
      'tax': 18,
      'discount': 15,
      'totalPrice': 950
    }
  ];

  void showInvoice(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Ensures the bottom sheet can expand fully
      enableDrag: true,
      builder: (BuildContext context) {
        return InvoiceBottomsheet.bottomSheet(context, items);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showInvoice(context),
      child: Container(
        margin: const EdgeInsets.only(bottom: 5),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Card(
          elevation: 6,
          color: Theme.of(context).colorScheme.surfaceContainerHigh,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            // side: BorderSide(color: Theme.of(context).colorScheme.outline),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 8,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Harsh Kumar",
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(fontWeight: FontWeight.bold),
                  // textAlign: TextAlign.left,
                ),
                // Wrap(
                //   // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   runAlignment: WrapAlignment.spaceBetween,
                //   children: [
                //     Text(
                //       "Vend Gopal MutuSwami Iyer",
                //       style: Theme.of(context)
                //           .textTheme
                //           .headlineSmall!
                //           .copyWith(fontWeight: FontWeight.bold),
                //     ),
                //     const Icon(Icons.edit)
                //   ],
                // ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Text(
                      'INV00001',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total: ₹1000',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Text(
                        DateFormat('d MMMM yyyy')
                            .format(Timestamp.now().toDate()),
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurface
                                  .withOpacity(0.6),
                            ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
