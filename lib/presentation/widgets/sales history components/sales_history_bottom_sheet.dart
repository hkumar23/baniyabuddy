import 'package:baniyabuddy/constants/app_language.dart';
import 'package:baniyabuddy/data/models/transaction.model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SalesHistoryBottomSheet extends StatelessWidget {
  const SalesHistoryBottomSheet({super.key, required this.transactionDetails});
  final TransactionDetails transactionDetails;

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final paymentMethodColor =
        transactionDetails.paymentMethod == AppLanguage.amountDue
            ? Colors.red
            : transactionDetails.paymentMethod == "Not Selected"
                ? Theme.of(context).colorScheme.onSurface.withOpacity(0.6)
                : Colors.green;

    return
        // BottomSheet(
        //   enableDrag: false,
        //   elevation: 10,
        //   onClosing: () {},
        //   builder: (ctx) =>
        Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            // height: deviceSize.height * 0.6,
            child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 15),
                    Text(
                      transactionDetails.customerName,
                      style:
                          Theme.of(context).textTheme.headlineMedium!.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 7),
                      width: deviceSize.width,
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.end,
                        alignment: WrapAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total Amount: ",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                          Text(
                            transactionDetails.totalAmount == null ||
                                    transactionDetails.totalAmount == ""
                                ? "₹ 0"
                                : "₹ ${transactionDetails.totalAmount.toString()}",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                  fontWeight: FontWeight.bold,
                                  // fontStyle: FontStyle.italic,
                                ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Payment Method:",
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                        Text(
                          transactionDetails.paymentMethod,
                          style: transactionDetails.paymentMethod ==
                                  AppLanguage.notSelected
                              ? Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                    color: paymentMethodColor,
                                  )
                              : transactionDetails.paymentMethod ==
                                          AppLanguage.cash ||
                                      transactionDetails.paymentMethod ==
                                          AppLanguage.upi
                                  ? Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(
                                        color: paymentMethodColor,
                                        fontWeight: FontWeight.bold,
                                      )
                                  : Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                        color: paymentMethodColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Phone Number:",
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                        Text(
                          transactionDetails.mobNumber.isEmpty
                              ? "Not Given"
                              : "+91 ${transactionDetails.mobNumber}",
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "Calculation:",
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                    Text(
                      transactionDetails.totalAmount == null ||
                              transactionDetails.totalAmount == ""
                          ? "0"
                          : transactionDetails.inputExpression!,
                      // overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(),
                    ),
                    const SizedBox(height: 5),
                    if (transactionDetails.notes.isNotEmpty)
                      Text(
                        "Notes:",
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  fontWeight: FontWeight.w500,
                                ),
                      ),
                    if (transactionDetails.notes.isNotEmpty)
                      Text(
                        transactionDetails.notes,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Date & Time: ",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Text(
                          DateFormat('h:mm a, d MMMM yyyy')
                              .format(transactionDetails.timeStamp),
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                  ]),
            ));
    // );
  }
}
