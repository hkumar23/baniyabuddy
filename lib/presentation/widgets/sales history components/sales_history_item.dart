import 'package:baniyabuddy/constants/app_language.dart';
import 'package:baniyabuddy/data/models/sales_record_details.dart';
import 'package:baniyabuddy/presentation/widgets/sales%20history%20components/sales_history_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SalesHistoryItem extends StatelessWidget {
  const SalesHistoryItem({
    super.key,
    required this.deviceSize,
    required this.saleDetails,
  });

  final Size deviceSize;
  final SalesRecordDetails saleDetails;

  @override
  Widget build(BuildContext context) {
    Color paymentMethodColor = saleDetails.paymentMethod == AppLanguage.udhaar
        ? Colors.red
        : saleDetails.paymentMethod == AppLanguage.notSelected
            ? Theme.of(context).colorScheme.onSurface.withOpacity(0.6)
            : Colors.green;
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
            elevation: 10,
            context: context,
            builder: (ctx) {
              return SalesHistoryBottomSheet(saleDetails: saleDetails);
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
                      saleDetails.costumerName,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                    ),
                    Text(
                      DateFormat('d MMMM yyyy').format(saleDetails.timeStamp),
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
                      saleDetails.paymentMethod,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: paymentMethodColor,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Text(
                      saleDetails.totalAmount == null ||
                              saleDetails.totalAmount == ""
                          ? "₹ 0"
                          : "₹ ${saleDetails.totalAmount}",
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
    // SizedBox(
    //   height: 140,
    //   width: deviceSize.width,
    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       Row(
    //         children: [
    //           Text(
    //             "14/06/2024",
    //             style: Theme.of(context).textTheme.labelMedium!.copyWith(
    //                   color: Theme.of(context)
    //                       .colorScheme
    //                       .onSurface
    //                       .withOpacity(0.6),
    //                 ),
    //           ),
    //           const Spacer(),
    //           Text(
    //             "11:25 am",
    //             style: Theme.of(context).textTheme.labelMedium!.copyWith(
    //                   color: Theme.of(context)
    //                       .colorScheme
    //                       .onSurface
    //                       .withOpacity(0.6),
    //                 ),
    //           ),
    //         ],
    //       ),
    //       Row(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
    //           Expanded(
    //             flex: 3,
    //             child: Column(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: [
    //                 Text(
    //                   "Costumer Nameph",
    //                   style:
    //                       Theme.of(context).textTheme.titleLarge!.copyWith(
    //                             fontWeight: FontWeight.w500,
    //                           ),
    //                 ),
    //                 Text("+91 1234567890",
    //                     style: Theme.of(context).textTheme.titleMedium!),
    //                 Text(
    //                   "Notes:",
    //                   style: Theme.of(context).textTheme.titleMedium,
    //                 ),
    //                 Text(
    //                   "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation.",
    //                   style: Theme.of(context).textTheme.bodySmall,
    //                   overflow: TextOverflow.ellipsis,
    //                   maxLines: 3,
    //                 ),
    //               ],
    //             ),
    //           ),
    //           const SizedBox(width: 10),
    //           Expanded(
    //             flex: 2,
    //             child: Column(
    //               // mainAxisAlignment: MainAxisAlignment.start,
    //               crossAxisAlignment: CrossAxisAlignment.end,
    //               // mainAxisSize: MainAxisSize.max,
    //               children: [
    //                 const SizedBox(height: 5),
    //                 Text(
    //                   "Calculation:",
    //                   style: Theme.of(context).textTheme.labelMedium,
    //                 ),
    //                 Text(
    //                   "1000*5+90*565466+165165*61616-165466+1641646*",
    //                   overflow: TextOverflow.ellipsis,
    //                   style:
    //                       Theme.of(context).textTheme.titleMedium!.copyWith(
    //                             fontWeight: FontWeight.w500,
    //                           ),
    //                 ),
    //                 Text(
    //                   "Total:",
    //                   style: Theme.of(context).textTheme.labelMedium,
    //                 ),
    //                 Text(
    //                   "₹ 1000",
    //                   style:
    //                       Theme.of(context).textTheme.titleLarge!.copyWith(
    //                             fontWeight: FontWeight.bold,
    //                           ),
    //                 ),
    //                 Text(
    //                   "Udhaar",
    //                   style:
    //                       Theme.of(context).textTheme.titleMedium!.copyWith(
    //                             color: Colors.red,
    //                             fontWeight: FontWeight.bold,
    //                           ),
    //                 ),
    //                 // Text(
    //                 //   "14/062024  11:24 am",
    //                 //   style: Theme.of(context).textTheme.labelMedium!.copyWith(
    //                 //         color: Theme.of(context)
    //                 //             .colorScheme
    //                 //             .onSurface
    //                 //             .withOpacity(0.6),
    //                 //       ),
    //                 // ),
    //               ],
    //             ),
    //           ),
    //         ],
    //       ),
    //     ],
    //   ),
    //   // color: Colors.amber,
    // ),
    // Divider(
    //   color: Theme.of(context).colorScheme.onSurface.withOpacity(0.4),
    //   thickness: 1.5,
    //   height: 30,
  }
}
