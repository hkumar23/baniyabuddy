import 'package:baniyabuddy/constants/app_constants.dart';
import 'package:baniyabuddy/constants/app_language.dart';
import 'package:baniyabuddy/data/models/transaction.model.dart';
import 'package:baniyabuddy/presentation/screens/calculator/bloc/calculator_bloc.dart';
import 'package:baniyabuddy/presentation/screens/calculator/bloc/calculator_event.dart';
import 'package:baniyabuddy/presentation/screens/calculator/bloc/calculator_state.dart';
import 'package:baniyabuddy/presentation/widgets/payment_method_dropdown.dart';
import 'package:baniyabuddy/utils/app_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecordSaleDialog extends StatefulWidget {
  const RecordSaleDialog({super.key});
  @override
  State<RecordSaleDialog> createState() => _RecordSaleDialogState();
}

class _RecordSaleDialogState extends State<RecordSaleDialog> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _customerNameController = TextEditingController();
  final TextEditingController _mobNumberController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  String? paymentMethod = AppLanguage.notSelected;

  void setPaymentMethod(String value) {
    setState(() {
      paymentMethod = value;
    });
  }

  @override
  void dispose() {
    _customerNameController.dispose();
    _mobNumberController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _trySubmit() {
    bool isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (!isValid) {
      return;
    }
    _formKey.currentState!.save();
    final transactionDetails = TransactionDetails(
      docId: null,
      isSynced: false,
      syncStatus: AppConstants.added,
      customerName: _customerNameController.text,
      mobNumber: _mobNumberController.text,
      notes: _notesController.text,
      paymentMethod: paymentMethod!,
      timeStamp: DateTime.now(),
      totalAmount: context.read<CalculatorBloc>().state.output,
      inputExpression: context.read<CalculatorBloc>().state.inputExpression,
    );
    BlocProvider.of<CalculatorBloc>(context)
        .add(SaveTransactionEvent(transactionDetails: transactionDetails));
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(0),
      title: const Text(
        'Record Sale',
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      content: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Form(
          // autovalidateMode: AutovalidateMode.onUserInteraction,
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                key: const Key(AppConstants.customerName),
                controller: _customerNameController,
                validator: (value) {
                  // if (value == null || value.isEmpty) {
                  //   return 'Please enter costumer name';
                  // }
                  if (value == null) return null;
                  if (value.length > 20) {
                    return 'Name should be less than 20 characters';
                  }
                  return null;
                },
                keyboardType: TextInputType.name,
                decoration:
                    const InputDecoration(labelText: AppLanguage.customerName),
              ),
              TextFormField(
                key: const Key(AppConstants.mobNumber),
                controller: _mobNumberController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return null;
                  }
                  if (value.length != 10 || !AppMethods.isNumeric(value)) {
                    return 'Please enter valid mobile number';
                  }
                  return null;
                },
                keyboardType: TextInputType.phone,
                maxLength: 10,
                decoration: const InputDecoration(
                  labelText: AppLanguage.mobNumber,
                  prefix: Text("+91 "),
                ),
              ),
              TextFormField(
                key: const Key(AppConstants.notes),
                controller: _notesController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return null;
                  }
                  if (value.length > 100) {
                    return 'Notes should be less than 100 characters';
                  }
                  return null;
                },
                keyboardType: TextInputType.multiline,
                maxLines: 3,
                minLines: 1,
                decoration: const InputDecoration(labelText: AppLanguage.notes),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 5),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Theme.of(context)
                          .colorScheme
                          .onSecondaryContainer
                          .withOpacity(0.5),
                      width: 1,
                      style: BorderStyle.solid,
                    ),
                  ),
                ),
                child: PaymentMethodDropdown(
                  setPaymentMethod: setPaymentMethod,
                  paymentMethod: paymentMethod,
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        BlocBuilder<CalculatorBloc, CalculatorState>(
          builder: (context, state) {
            return TextButton(
              onPressed: _trySubmit,
              child: state is CalcLoadingState
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : const Text('Save'),
            );
          },
        ),
      ],
    );
  }
}
