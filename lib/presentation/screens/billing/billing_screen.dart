import 'package:flutter/material.dart';

import '../../../data/models/invoice.model.dart';
import '../../../data/repositories/invoice_repo.dart';
import 'invoice_form_screen.dart';
import '../../widgets/billing components/invoice_item.dart';

class BillingScreen extends StatelessWidget {
  const BillingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Invoice> invoices = InvoiceRepo().getAllInvoices();
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(children: _buildInvoiceList(invoices)),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const InvoiceFormScreen();
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

List<Widget> _buildInvoiceList(List<Invoice> invoices) {
  List<Widget> invoiceItems = [];
  for (Invoice invoice in invoices) {
    invoiceItems.add(InvoiceItem(invoice: invoice));
  }
  invoiceItems.add(const SizedBox(height: 80));
  return invoiceItems;
}
