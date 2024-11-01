import 'package:flutter/material.dart';

import '../../../data/models/bill_item.model.dart';

class BillItemTile extends StatelessWidget {
  const BillItemTile({
    super.key,
    required this.billItem,
  });
  final BillItem billItem;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
      margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 4, // Item Name
            child: Text(
              billItem.itemName!,
              style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            flex: 2, // Quantity
            child: Column(
              children: [
                Text(
                  'Qty:',
                  style: textTheme.bodySmall!
                      .copyWith(fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
                Text(
                  billItem.quantity.toString(),
                  style: textTheme.bodySmall,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3, // Price
            child: Column(
              children: [
                Text(
                  'Price:',
                  style: textTheme.bodySmall!
                      .copyWith(fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
                Text(
                  '₹${billItem.unitPrice}',
                  style: textTheme.bodySmall,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          if (billItem.tax != null)
            Expanded(
              flex: 2, // Price
              child: Column(
                children: [
                  Text(
                    'Tax:',
                    style: textTheme.bodySmall!
                        .copyWith(fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    '${billItem.tax}%',
                    style: textTheme.bodySmall,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          if (billItem.discount != null)
            Expanded(
              flex: 3, // Price
              child: Column(
                children: [
                  Text(
                    'Discount:',
                    style: textTheme.bodySmall!
                        .copyWith(fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    '${billItem.discount}%',
                    style: textTheme.bodySmall,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          Expanded(
            flex: 3, // Total
            child: Column(
              children: [
                Text(
                  'Total:',
                  style: textTheme.bodySmall
                      ?.copyWith(fontWeight: FontWeight.w600),
                  textAlign: TextAlign.end,
                ),
                Text(
                  '₹ ${billItem.totalPrice}',
                  style: textTheme.bodySmall
                      ?.copyWith(fontWeight: FontWeight.w600),
                  textAlign: TextAlign.end,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
