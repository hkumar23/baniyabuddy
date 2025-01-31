import 'package:baniyabuddy/constants/app_language.dart';
import 'package:flutter/material.dart';

class PaymentMethodDropdown extends StatefulWidget {
  const PaymentMethodDropdown({
    super.key,
    required this.setPaymentMethod,
    required this.paymentMethod,
  });
  final Function setPaymentMethod;
  final String? paymentMethod;
  @override
  State<PaymentMethodDropdown> createState() => _PaymentMethodDropdownState();
}

class _PaymentMethodDropdownState extends State<PaymentMethodDropdown> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      hint: const Text("Select Payment Method"),
      isExpanded: true,
      underline: Container(),
      itemHeight: 50,
      value: widget.paymentMethod,
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
          value: AppLanguage.unpaid,
          child: Text(AppLanguage.unpaid),
        ),
        DropdownMenuItem(
          value: AppLanguage.netBanking,
          child: Text(AppLanguage.netBanking),
        ),
        DropdownMenuItem(
          value: AppLanguage.creditDebitCard,
          child: Text(AppLanguage.creditDebitCard),
        ),
        // DropdownMenuItem(
        //   value: AppLanguage.notSelected,
        //   child: Text(AppLanguage.notSelected),
        // ),
      ],
      onChanged: (String? value) {
        widget.setPaymentMethod(value);
      },
    );
  }
}
