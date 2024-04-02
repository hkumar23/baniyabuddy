import 'package:baniyabuddy/constants/app_language.dart';
import 'package:flutter/material.dart';

class SaveTransaction {
  static void saveTransactionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final TextEditingController costumerNameController =
            TextEditingController();
        final TextEditingController mobNumberController =
            TextEditingController();
        final TextEditingController notesController = TextEditingController();

        String? paymentMethod = AppLanguage.selectPaymentMethod;

        return AlertDialog(
          title: const Text('Save Transaction'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: costumerNameController,
                  decoration: const InputDecoration(labelText: 'Costumer Name'),
                ),
                TextField(
                  controller: mobNumberController,
                  decoration: const InputDecoration(labelText: 'Mobile Number'),
                ),
                TextField(
                  controller: notesController,
                  decoration: const InputDecoration(labelText: 'Notes'),
                ),
                // const TextField(
                //   decoration:
                //       InputDecoration(labelText: 'Select payment method'),
                // )
                DropdownButton(
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
                  onChanged: (String? value) {},
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
                // final customerDetails = CustomerDetails(
                //   name: nameController.text,
                //   email: emailController.text,
                //   phoneNumber: phoneNumberController.text,
                // );
                // BlocProvider.of<CalculatorBloc>(context).saveCalculationWithCustomerDetails(customerDetails);
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
