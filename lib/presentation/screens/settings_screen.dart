import 'package:baniyabuddy/data/models/invoice.model.dart';
import 'package:baniyabuddy/data/repositories/invoice_repo.dart';
import 'package:baniyabuddy/utils/work_in_progress.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: ElevatedButton(
            onPressed: () {
              InvoiceRepo repo = InvoiceRepo();
              var invoices = repo.getAllInvoices();
              if (invoices.isEmpty) {
                print("The Box is empty");
              }
              for (var invoice in invoices) {
                print(invoice.toJson());
              }
            },
            child: const Icon(Icons.abc)));
  }
}
