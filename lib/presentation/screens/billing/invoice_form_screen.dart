import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../main_screen.dart';
import '../../../utils/custom_snackbar.dart';
import 'bloc/billing_state.dart';
import 'bloc/billing_event.dart';
import 'bloc/billing_bloc.dart';
import '../../../data/models/bill_item.model.dart';
import '../../../data/models/invoice.model.dart';
import '../../../constants/app_language.dart';
import '../../../presentation/widgets/payment_method_dropdown.dart';
import '../../../utils/app_methods.dart';
import '../../widgets/billing components/add_billitem_button.dart';
import '../../widgets/billing components/custom_animated_button.dart';
import '../../widgets/billing components/bill_item_tile.dart';
import '../../widgets/billing components/add_billitem_dialog.dart';

class InvoiceFormScreen extends StatefulWidget {
  const InvoiceFormScreen({super.key});

  @override
  State<InvoiceFormScreen> createState() => _InvoiceFormScreenState();
}

class _InvoiceFormScreenState extends State<InvoiceFormScreen> {
  final _formKey = GlobalKey<FormState>();

  final _clientNameController = TextEditingController();
  final _addressController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _extraDiscountController = TextEditingController();
  final _shippingChargesController = TextEditingController();
  final _notesController = TextEditingController();

  List<BillItem> billItems = [];
  String? paymentMethod;
  void setPaymentMethod(String value) {
    setState(() {
      paymentMethod = value;
    });
  }

  void onSubmit(ctx) {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();
    context.read<BillingBloc>().add(
          GenerateInvoiceEvent(
            invoice: Invoice(
              docId: null,
              isSynced: false,
              invoiceNumber: null,
              invoiceDate: Timestamp.now().toDate(),
              paymentMethod: paymentMethod == AppLanguage.notSelected
                  ? null
                  : paymentMethod,
              clientName: _clientNameController.text,
              subtotal: null,
              grandTotal: null,
              billItems: billItems,
              clientAddress: _addressController.text.isEmpty
                  ? null
                  : _addressController.text,
              clientEmail:
                  _emailController.text.isEmpty ? null : _emailController.text,
              clientPhone:
                  _phoneController.text.isEmpty ? null : _phoneController.text,
              extraDiscount: double.tryParse(_extraDiscountController.text),
              notes:
                  _notesController.text.isEmpty ? null : _notesController.text,
              shippingCharges: double.tryParse(_shippingChargesController.text),
              totalDiscount: null,
              totalTaxAmount: null,
            ),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        AppMethods.shouldPopDialog(context);
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Create Invoice'),
        ),
        body: BlocConsumer<BillingBloc, BillingState>(
          listener: (context, state) {
            if (state is InvoiceGeneratedState) {
              CustomSnackbar.success(
                context: context,
                text: "Invoice Generated and saved in Download !!",
              );
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => const MainScreen(),
                ),
                (route) => false,
              );
            }
            if (state is BillingErrorState) {
              CustomSnackbar.error(
                context: context,
                text: state.errorMessage,
              );
            }
          },
          builder: (context, state) {
            if (state is BillingLoadingState) {
              return const Center(child: CircularProgressIndicator());
            }
            return Stack(
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
                          controller: _clientNameController,
                          decoration:
                              const InputDecoration(labelText: 'Client Name*'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the Client Name';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _addressController,
                          decoration:
                              const InputDecoration(labelText: 'Address'),
                        ),
                        TextFormField(
                          controller: _emailController,
                          decoration: const InputDecoration(labelText: 'Email'),
                          validator: (value) {
                            if (value == null || value.isEmpty) return null;
                            if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                .hasMatch(value)) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _phoneController,
                          decoration: const InputDecoration(
                            labelText: AppLanguage.phoneNumber,
                            prefix: Text("+91"),
                          ),
                          maxLength: 10,
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

                        Column(
                          children: billItems.map((item) {
                            return BillItemTile(
                              billItem: BillItem(
                                itemName: item.itemName,
                                quantity: item.quantity,
                                unitPrice: item.unitPrice,
                                totalPrice: item.totalPrice,
                                discount: item.discount,
                                tax: item.tax,
                              ),
                            );
                          }).toList(),
                        ),
                        // Add item button
                        const SizedBox(height: 10),
                        GestureDetector(
                          onTap: () async {
                            await showDialog(
                              context: context,
                              builder: (context) {
                                return AddBillitemDialog(billItems: billItems);
                              },
                            );
                            setState(() {});
                          },
                          child: const AddBillItemButton(),
                        ),
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
                              flex: 1,
                              child: TextFormField(
                                controller: _extraDiscountController,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  prefix: Icon(
                                    Icons.currency_rupee,
                                    size: 15,
                                  ),
                                  labelText: AppLanguage.extraDiscount,
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return null;
                                  }
                                  if (!AppMethods.isNumeric(value)) {
                                    return "Enter a valid amount";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(width: 7),
                            Expanded(
                              flex: 1,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 3,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.white54),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(5)),
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
                          controller: _shippingChargesController,
                          decoration: const InputDecoration(
                            labelText: 'Shipping Charges',
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
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: _notesController,
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
                  child: BlocBuilder<BillingBloc, BillingState>(
                    builder: (context, state) {
                      return GestureDetector(
                        onTap: () {
                          onSubmit(context);
                        },
                        child: const Padding(
                          padding: EdgeInsets.only(bottom: 20),
                          child: CustomAnimatedButton(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
