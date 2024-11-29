import 'package:flutter/material.dart';

class BusinessInfoDialog extends StatefulWidget {
  const BusinessInfoDialog({super.key});

  @override
  State<BusinessInfoDialog> createState() => _BusinessInfoDialogState();
}

class _BusinessInfoDialogState extends State<BusinessInfoDialog> {
  final _formKey = GlobalKey<FormState>();

  final _businessNameController = TextEditingController();

  final _addressController = TextEditingController();

  final _emailController = TextEditingController();

  final _phoneController = TextEditingController();

  final _gstinController = TextEditingController();

  bool validateGSTNumber(String gstNumber) {
    const gstRegEx =
        r'^[0-3][0-9][A-Z]{5}[0-9]{4}[A-Z]{1}[A-Z0-9]{1}[Z]{1}[A-Z0-9]{1}$';
    return RegExp(gstRegEx).hasMatch(gstNumber);
  }

  void _onSubmit(BuildContext context) {
    if (!_formKey.currentState!.validate()) return;
    // _formKey.currentState!.save();
    print("On Submit");
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        // decoration: BoxDecoration(
        //   borderRadius: const BorderRadius.all(
        //     Radius.circular(50),
        //   ),
        //   color: colorScheme.surface,
        // ),
        padding: const EdgeInsets.symmetric(
          vertical: 24,
          horizontal: 20,
        ),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Enter your business details",
                  style: textTheme.headlineMedium,
                ),
                TextFormField(
                  controller: _businessNameController,
                  decoration: const InputDecoration(
                    label: Text("Business Name"),
                  ),
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Business Name is required..!";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _addressController,
                  decoration: const InputDecoration(
                    label: Text("Address"),
                  ),
                  keyboardType: TextInputType.streetAddress,
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    label: Text("Email Address"),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) return null;

                    value = value.trim();
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _phoneController,
                  decoration: const InputDecoration(
                    prefix: Text("+91"),
                    label: Text("Phone Number"),
                  ),
                  keyboardType: TextInputType.phone,
                  maxLength: 10,
                  validator: (value) {
                    if (value == null || value.isEmpty) return null;
                    if (value.length < 10 || double.tryParse(value) == null) {
                      return 'Please enter a valid phone number';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _gstinController,
                  decoration: const InputDecoration(
                    label: Text("GST Number"),
                  ),
                  keyboardType: TextInputType.text,
                  maxLength: 15,
                  validator: (value) {
                    if (value == null || value.isEmpty) return null;
                    if (!validateGSTNumber(value)) {
                      return "Invalid GST Number..!";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FilledButton(
                        onPressed: () {
                          _onSubmit(context);
                        },
                        child: Text(
                          "Save Details",
                          style: textTheme.labelLarge!.copyWith(
                              color: colorScheme.onPrimary,
                              fontWeight: FontWeight.bold),
                        )),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
