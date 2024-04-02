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

        String? paymentMethod = "Select payment method";
        int cnt = 0;

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
                DropdownButton<String>(
                  value: paymentMethod,
                  items: const [
                    DropdownMenuItem<String>(
                        value: "Cash", child: Text("Cash")),
                    DropdownMenuItem<String>(value: "UPI", child: Text("UPI")),
                    DropdownMenuItem<String>(
                        value: "Udhaar", child: Text("Udhaar")),
                  ],
                  onChanged: (String? newValue) {
                    cnt++;
                    paymentMethod = cnt.toString();
                  },
                ),
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
