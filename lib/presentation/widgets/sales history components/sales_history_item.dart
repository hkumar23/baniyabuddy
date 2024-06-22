import 'package:baniyabuddy/constants/app_language.dart';
import 'package:baniyabuddy/data/models/transaction_details.dart';
import 'package:baniyabuddy/presentation/widgets/sales%20history%20components/sales_history_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SalesHistoryItem extends StatelessWidget {
  const SalesHistoryItem({
    super.key,
    required this.transactionDetails,
  });

  final TransactionDetails transactionDetails;
  @override
  Widget build(BuildContext context) {
    // final deviceSize = MediaQuery.of(context).size;
    Color paymentMethodColor =
        transactionDetails.paymentMethod == AppLanguage.udhaar
            ? Colors.red
            : transactionDetails.paymentMethod == AppLanguage.notSelected
                ? Theme.of(context).colorScheme.onSurface.withOpacity(0.6)
                : Colors.green;
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
            elevation: 10,
            context: context,
            builder: (ctx) {
              return SalesHistoryBottomSheet(
                  transactionDetails: transactionDetails);
            });
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 9, top: 3),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.4),
            ),
            borderRadius: BorderRadius.circular(10),
            // color: Theme.of(context).colorScheme.onSurface.withOpacity(0.05),
          ),
          // elevation: 10,
          // color: Theme.of(context).colorScheme.secondaryContainer,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      transactionDetails.costumerName,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                    ),
                    Text(
                      DateFormat('d MMMM yyyy')
                          .format(transactionDetails.timeStamp),
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withOpacity(0.6),
                          ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      transactionDetails.paymentMethod,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: paymentMethodColor,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Text(
                      transactionDetails.totalAmount == null ||
                              transactionDetails.totalAmount == ""
                          ? "₹ 0"
                          : "₹ ${transactionDetails.totalAmount}",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
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
