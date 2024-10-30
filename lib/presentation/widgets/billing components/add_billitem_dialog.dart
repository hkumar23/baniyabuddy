import 'package:baniyabuddy/constants/app_constants.dart';
import 'package:flutter/material.dart';

import '../../../constants/app_language.dart';
import '../../../data/models/bill_item.model.dart';

class AddBillitemDialog extends StatelessWidget {
  AddBillitemDialog({
    super.key,
    required this.billItems,
  });
  List<BillItem> billItems;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _itemNameController = TextEditingController();

  final TextEditingController _quantityController = TextEditingController();

  final TextEditingController _unitPriceController = TextEditingController();

  final TextEditingController _taxController = TextEditingController();

  final TextEditingController _discountController = TextEditingController();

  void submitData(context) {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    int qty = int.parse(_quantityController.text);
    double unitPrice = double.parse(_unitPriceController.text);
    unitPrice = double.parse(unitPrice.toStringAsFixed(2));
    double? tax = double.tryParse(_taxController.text);
    double? discount = double.tryParse(_discountController.text);

    double totalPrice = qty * unitPrice;
    if (discount != null) {
      discount = double.parse(discount.toStringAsFixed(2));
      totalPrice = totalPrice - (totalPrice * discount) / 100;
    }
    if (tax != null) {
      tax = double.parse(tax.toStringAsFixed(2));
      totalPrice = totalPrice + (totalPrice * tax) / 100;
    }
    totalPrice = double.parse(totalPrice.toStringAsFixed(2));

    billItems.add(BillItem(
      itemName: _itemNameController.text,
      quantity: qty,
      unitPrice: unitPrice,
      totalPrice: totalPrice,
      discount: discount,
      tax: tax,
    ));

    Navigator.of(context).pop(); // Close the dialog
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AlertDialog(
      backgroundColor: theme.colorScheme.secondaryContainer,
      title: const Text(AppLanguage.addItem),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _itemNameController,
                decoration: const InputDecoration(labelText: "Item Name*"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter item name";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _quantityController,
                      decoration: const InputDecoration(
                          labelText: "${AppLanguage.quantity}*"),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter Quantity";
                        }
                        if (int.tryParse(value) == null) {
                          return "Invalid Integer";
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 7),
                  Expanded(
                    child: TextFormField(
                      controller: _unitPriceController,
                      decoration: const InputDecoration(
                        labelText: "${AppLanguage.unitPrice}*",
                        prefix: Icon(
                          Icons.currency_rupee,
                          size: 15,
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter unit price";
                        }
                        if (double.tryParse(value) == null) {
                          return "Invalid Amount";
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _taxController,
                      decoration: const InputDecoration(
                        labelText: "${AppLanguage.tax} in %",
                        suffix: Icon(
                          Icons.percent,
                          size: 20,
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return null;
                        }
                        if (double.tryParse(value) == null) {
                          return "Invalid Value";
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 7),
                  Expanded(
                    child: TextFormField(
                      controller: _discountController,
                      decoration: const InputDecoration(
                        labelText: "${AppLanguage.discount} in %",
                        suffix: Icon(
                          Icons.percent,
                          size: 20,
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return null;
                        }
                        if (double.tryParse(value) == null ||
                            double.parse(value) > 100) {
                          return "Invalid Value";
                        }

                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () =>
              Navigator.of(context).pop(), // Close the dialog without saving
          child: Text(
            AppLanguage.cancel,
            style: theme.textTheme.labelLarge!.copyWith(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        FilledButton(
          style: FilledButton.styleFrom(
            backgroundColor: theme.colorScheme.primary,
            foregroundColor: theme.colorScheme.onPrimary,
          ),
          onPressed: () {
            submitData(context);
          }, // Validate and save
          child: Text(
            AppLanguage.add,
            style: theme.textTheme.labelLarge!.copyWith(
              color: theme.colorScheme.onPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
