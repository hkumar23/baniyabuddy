import 'package:baniyabuddy/presentation/screens/invoice_form_screen.dart';
import 'package:flutter/material.dart';

import '../widgets/billing components/invoice_item.dart';

class BillingScreen extends StatelessWidget {
  const BillingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(children: _buildInvoiceList()),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return InvoiceFormScreen();
                  },
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: const BorderRadius.all(Radius.circular(30)),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black45,
                      spreadRadius: 5, // How much the shadow spreads
                      blurRadius: 7, // The blur effect of the shadow
                      offset: Offset(
                          0, 3), // Horizontal (x) and Vertical (y) offset
                    ),
                  ]),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.add_rounded,
                    size: 30,
                    color: Theme.of(context).colorScheme.surface,
                  ),
                  Text(
                    "Create Invoice",
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Theme.of(context).colorScheme.surface,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

List<Widget> _buildInvoiceList(
    // List<TransactionDetails> transactionsList,
    ) {
  List<Widget> invoiceItems = [];
  for (int i = 0; i < 10; i++) {
    invoiceItems.add(InvoiceItem());
  }
  invoiceItems.add(const SizedBox(height: 80));
  return invoiceItems;
}
