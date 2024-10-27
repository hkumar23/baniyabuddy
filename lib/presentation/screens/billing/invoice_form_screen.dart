import 'package:baniyabuddy/constants/app_language.dart';
import 'package:baniyabuddy/presentation/widgets/billing%20components/custom_animated_button.dart';
import 'package:baniyabuddy/presentation/widgets/payment_method_dropdown.dart';
import 'package:baniyabuddy/utils/app_methods.dart';
import 'package:flutter/material.dart';

import '../../widgets/billing components/add_billitem_button.dart';

class InvoiceFormScreen extends StatefulWidget {
  const InvoiceFormScreen({super.key});

  @override
  State<InvoiceFormScreen> createState() => _InvoiceFormScreenState();
}

class _InvoiceFormScreenState extends State<InvoiceFormScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController clientNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController extraDiscountController = TextEditingController();
  final TextEditingController shippingChargesController =
      TextEditingController();
  final TextEditingController notesController = TextEditingController();

  String? paymentMethod = AppLanguage.notSelected;
  void setPaymentMethod(String value) {
    setState(() {
      paymentMethod = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // InvoiceDetails();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Invoice'),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Client Details
                  Text(
                    'Client Details',
                    style: theme.textTheme.titleLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: clientNameController,
                    decoration:
                        const InputDecoration(labelText: 'Client Name*'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the client name';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: addressController,
                    decoration: const InputDecoration(labelText: 'Address'),
                  ),
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(labelText: 'Email'),
                    validator: (value) {
                      if (value == null || value.isEmpty) return null;
                      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: phoneController,
                    decoration: const InputDecoration(
                      labelText: 'Phone Number',
                      prefix: Text("+91"),
                    ),
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) return null;
                      if (value.length != 10) {
                        return 'Phone number must be 10 digits';
                      }
                      if (!AppMethods.isNumeric(value)) {
                        return "Enter a valid Phone Number";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  // Item Details
                  Text(
                    'Item Details',
                    style: theme.textTheme.titleLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  // Add item button
                  const AddItemButtonInvoice(),
                  const SizedBox(height: 20),
                  Text(
                    'Others',
                    style: theme.textTheme.titleLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: TextFormField(
                          controller: extraDiscountController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            prefix: Icon(
                              Icons.currency_rupee,
                              size: 15,
                            ),
                            labelText: AppLanguage.extraDiscount,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) return null;
                            if (!AppMethods.isNumeric(value)) {
                              return "Enter a valid amount";
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(width: 7),
                      Expanded(
                        flex: 4,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white54),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5)),
                          ),
                          child: PaymentMethodDropdown(
                            setPaymentMethod: setPaymentMethod,
                            paymentMethod: paymentMethod,
                          ),
                        ),
                      )
                    ],
                  ),
                  TextFormField(
                    controller: shippingChargesController,
                    decoration: const InputDecoration(
                      labelText: 'Shipping Charges',
                      border: InputBorder.none,
                      prefix: Icon(
                        Icons.currency_rupee,
                        size: 15,
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) return null;
                      if (!AppMethods.isNumeric(value)) {
                        return 'Enter a valid amount';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: notesController,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      alignLabelWithHint: true,
                      labelText: 'Notes',
                      border: OutlineInputBorder(),
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(bottom: 50),
                        child: Icon(Icons.notes),
                      ),
                    ),
                    keyboardType: TextInputType.multiline,
                  ),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),
          // Submit Button
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: FilledButton(
                style: ButtonStyle(
                  shadowColor: const WidgetStatePropertyAll(Colors.black),
                  backgroundColor: WidgetStatePropertyAll(
                    theme.colorScheme.tertiary,
                  ),
                  foregroundColor: WidgetStatePropertyAll(
                    theme.colorScheme.onTertiary,
                  ),
                ),
                onPressed: () {},
                child: Text(
                  'Generate Pdf',
                  style: theme.textTheme.titleMedium!.copyWith(
                    color: theme.colorScheme.onTertiary,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
