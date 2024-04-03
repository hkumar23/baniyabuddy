import 'package:baniyabuddy/constants/app_constants.dart';
import 'package:baniyabuddy/constants/app_language.dart';
import 'package:baniyabuddy/data/models/transaction_details.dart';
import 'package:flutter/material.dart';

class SaveTransactionDialog extends StatefulWidget {
  const SaveTransactionDialog({super.key});

  @override
  State<SaveTransactionDialog> createState() => _SaveTransactionDialogState();
}

class _SaveTransactionDialogState extends State<SaveTransactionDialog> {
  final TextEditingController costumerNameController = TextEditingController();
  final TextEditingController mobNumberController = TextEditingController();
  final TextEditingController notesController = TextEditingController();
  String? paymentMethod = AppLanguage.selectPaymentMethod;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Save Transaction'),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: costumerNameController,
              decoration:
                  const InputDecoration(labelText: AppLanguage.costumerName),
            ),
            TextField(
              controller: mobNumberController,
              decoration:
                  const InputDecoration(labelText: AppLanguage.mobNumber),
            ),
            TextField(
              controller: notesController,
              decoration: const InputDecoration(labelText: AppLanguage.notes),
            ),
            // const TextField(
            //   decoration:
            //       InputDecoration(labelText: 'Select payment method'),
            // )
            DropdownButton(
              isExpanded: true,
              itemHeight: 70,
              value: paymentMethod,
              items: const [
                DropdownMenuItem(
                  value: AppLanguage.cash,
                  child: Text(AppLanguage.cash),
                ),
                DropdownMenuItem(
                  value: AppLanguage.upi,
                  child: Text(AppLanguage.upi),
                ),
                DropdownMenuItem(
                  value: AppLanguage.udhaar,
                  child: Text(AppLanguage.udhaar),
                ),
                DropdownMenuItem(
                  value: AppLanguage.selectPaymentMethod,
                  child: Text(AppLanguage.selectPaymentMethod),
                ),
              ],
              onChanged: (String? value) {
                setState(() {
                  paymentMethod = value;
                });
              },
            )
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            final transactionDetails = TransactionDetails(
              costumerName: costumerNameController.text,
              mobNumber: mobNumberController.text,
              notes: notesController.text,
              paymentMethod: paymentMethod!,
            );
            // BlocProvider.of<CalculatorBloc>(context).saveCalculationWithCustomerDetails(customerDetails);
            Navigator.of(context).pop();
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
