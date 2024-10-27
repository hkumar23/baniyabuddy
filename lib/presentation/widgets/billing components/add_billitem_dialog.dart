import 'package:baniyabuddy/constants/app_language.dart';
import 'package:flutter/material.dart';

class AddBillitemDialog extends StatefulWidget {
  const AddBillitemDialog({super.key});

  @override
  _AddBillitemDialogState createState() => _AddBillitemDialogState();
}

class _AddBillitemDialogState extends State<AddBillitemDialog> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _itemNameController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _unitPriceController = TextEditingController();
  final TextEditingController _taxController = TextEditingController();
  final TextEditingController _discountController = TextEditingController();

  void _submitData() {
    if (_formKey.currentState!.validate()) {
      Navigator.of(context).pop(); // Close the dialog
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      title: const Text("Add Item"),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _itemNameController,
                decoration: const InputDecoration(labelText: "Item Name"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter an item name";
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
                      decoration: const InputDecoration(labelText: "Quantity"),
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
                        labelText: "Unit Price",
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
                          return "Enter a valid amount";
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
                        labelText: "Tax in %",
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
                        labelText: "Discount in %",
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
          child: const Text(AppLanguage.cancel),
        ),
        FilledButton(
          style: FilledButton.styleFrom(
            backgroundColor: theme.colorScheme.onSecondaryContainer,
            foregroundColor: theme.colorScheme.surface,
          ),
          onPressed: _submitData, // Validate and save
          child: const Text(AppLanguage.save),
        ),
      ],
    );
  }
}

// Usage
void showAddBillitemDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (ctx) => const AddBillitemDialog(),
  );
}
