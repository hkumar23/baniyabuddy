import 'package:baniyabuddy/constants/app_language.dart';
import 'package:baniyabuddy/data/models/transaction.model.dart';
import 'package:baniyabuddy/presentation/screens/sales_history/bloc/sales_history_bloc.dart';
import 'package:baniyabuddy/presentation/screens/sales_history/bloc/sales_history_event.dart';
import 'package:baniyabuddy/presentation/screens/sales_history/bloc/sales_history_state.dart';
import 'package:baniyabuddy/presentation/widgets/sales%20history%20components/sales_history_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class SalesHistoryItem extends StatelessWidget {
  const SalesHistoryItem({
    super.key,
    required this.transactionDetails,
  });

  final TransactionDetails transactionDetails;
  @override
  Widget build(BuildContext context) {
    Future<bool> showDebugDialog(BuildContext context) async {
      return await showDialog(
              context: context,
              builder: (ctx) {
                return AlertDialog(
                  backgroundColor: Theme.of(context).colorScheme.surface,
                  title: Text(
                    transactionDetails.customerName.isEmpty
                        ? "Unknown"
                        : transactionDetails.customerName,
                  ),
                  content: const Text(
                      "Are you sure you want to delete this transaction?"),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      },
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(true);
                        // isDeleted = true;
                      },
                      // style: ButtonStyle(
                      //   backgroundColor: MaterialStatePropertyAll<Color>(
                      //     Theme.of(context).colorScheme.error,
                      //   ),
                      // ),
                      child: const Text(
                        "Delete",
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                );
              }) ??
          false;
    }

    // final deviceSize = MediaQuery.of(context).size;
    Color paymentMethodColor =
        transactionDetails.paymentMethod == AppLanguage.unpaid
            ? Colors.red
            : transactionDetails.paymentMethod == AppLanguage.notSelected
                ? Theme.of(context).colorScheme.onSurface.withOpacity(0.6)
                : Colors.green;
    return BlocConsumer<SalesHistoryBloc, SalesHistoryState>(
      listener: (context, state) {
        if (state is TransactionsDeletedState) {
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Transaction deleted')),
          );
        }
      },
      builder: (context, state) {
        return Dismissible(
          key: Key(transactionDetails.docId!),
          direction: DismissDirection.endToStart,
          onDismissed: (direction) {
            context.read<SalesHistoryBloc>().add(
                  DeleteTransactionEvent(docId: transactionDetails.docId!),
                );
          },
          background: Container(
              color: Colors.red,
              child: const Icon(Icons.delete, color: Colors.white)),
          // onResize: () {
          confirmDismiss: (direction) async {
            return await showDebugDialog(context);
          },
          child: GestureDetector(
            onTap: () {
              showModalBottomSheet(
                  elevation: 10,
                  context: context,
                  builder: (ctx) {
                    return SalesHistoryBottomSheet(
                        transactionDetails: transactionDetails);
                  });
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 9, top: 3),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                border: Border.all(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.4),
                ),
                borderRadius: BorderRadius.circular(10),
                // color: Theme.of(context).colorScheme.onSurface.withOpacity(0.05),
              ),
              // elevation: 10,
              // color: Theme.of(context).colorScheme.secondaryContainer,

              child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        transactionDetails.customerName == ""
                            ? "Unknown"
                            : transactionDetails.customerName,
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                      ),
                      Text(
                        transactionDetails.totalAmount == null ||
                                transactionDetails.totalAmount == ""
                            ? "₹ 0"
                            : "₹ ${transactionDetails.totalAmount}",
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        transactionDetails.paymentMethod,
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  color: paymentMethodColor,
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                      const SizedBox(width: 7),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 3),
                        child: Text(
                          DateFormat('d MMMM yyyy')
                              .format(transactionDetails.timeStamp),
                          style:
                              Theme.of(context).textTheme.labelMedium!.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface
                                        .withOpacity(0.6),
                                  ),
                        ),
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 3),
                        child: Text(
                          "Tap for details",
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium!
                              .copyWith(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
