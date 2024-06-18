import 'package:baniyabuddy/constants/app_language.dart';
import 'package:baniyabuddy/data/models/sales_record_details.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SalesHistoryBottomSheet extends StatelessWidget {
  const SalesHistoryBottomSheet({super.key, required this.saleDetails});
  final SalesRecordDetails saleDetails;
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final paymentMethodColor = saleDetails.paymentMethod == "Udhaar"
        ? Colors.red
        : saleDetails.paymentMethod == "Not Selected"
            ? Theme.of(context).colorScheme.onSurface.withOpacity(0.6)
            : Colors.green;
    return BottomSheet(
      enableDrag: false,
      elevation: 10,
      onClosing: () {},
      builder: (ctx) => Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          // height: deviceSize.height * 0.6,
          child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 15),
                  Text(
                    saleDetails.costumerName,
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
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
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                        Text(
                          saleDetails.totalAmount == null ||
                                  saleDetails.totalAmount == ""
                              ? "₹ 0"
                              : "₹ ${saleDetails.totalAmount.toString()}",
                          style:
                              Theme.of(context).textTheme.titleLarge!.copyWith(
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
                        saleDetails.paymentMethod,
                        style: saleDetails.paymentMethod ==
                                AppLanguage.notSelected
                            ? Theme.of(context).textTheme.titleMedium!.copyWith(
                                  color: paymentMethodColor,
                                )
                            : Theme.of(context).textTheme.titleLarge!.copyWith(
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
                        saleDetails.mobNumber.isEmpty
                            ? "Not Given"
                            : "+91 ${saleDetails.mobNumber}",
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
                    saleDetails.totalAmount == null ||
                            saleDetails.totalAmount == ""
                        ? "0"
                        : saleDetails.inputExpression!,
                    // overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(),
                  ),
                  const SizedBox(height: 5),
                  if (saleDetails.notes.isNotEmpty)
                    Text(
                      "Notes:",
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  if (saleDetails.notes.isNotEmpty)
                    Text(
                      saleDetails.notes,
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
                            .format(saleDetails.timeStamp),
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                ]),
          )),
    );
  }
}
