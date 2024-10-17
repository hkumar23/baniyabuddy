import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class InvoiceItem extends StatelessWidget {
  const InvoiceItem({super.key});

  @override
  Widget build(BuildContext context) {
    // return Container(
    //     padding: const EdgeInsets.symmetric(horizontal: 10),
    //     height: 80,
    //     child: Card(
    //       color: Theme.of(context).colorScheme.surfaceContainerHighest,
    //       child: const Row(
    //         mainAxisAlignment: MainAxisAlignment.spaceAround,
    //         children: [],
    //       ),
    //     ));
    int quantity = 50;
    int price = 40;
    int totalPrice = quantity * price;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      // height: 100,
      child: Card(
        elevation: 4,
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: Theme.of(context).colorScheme.outline),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "ItemName",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Quantity: $quantity',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Unit Price: ₹${price.toStringAsFixed(2)}',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Total: ₹${totalPrice.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                // Handle deletion of the invoice item
              },
            ),
          ],
        ),
      ),
    );
  }
}
