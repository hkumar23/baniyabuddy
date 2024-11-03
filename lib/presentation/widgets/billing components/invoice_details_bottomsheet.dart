import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:intl/intl.dart';

import '../../../constants/app_constants.dart';
import '../../../data/models/invoice.model.dart';

abstract class InvoiceBottomsheet {
  static BottomSheet bottomSheet(BuildContext context, Invoice invoice) {
    final theme = Theme.of(context);
    return BottomSheet(
      onClosing: () {}, // Required callback, but we handle closing manually
      builder: (BuildContext context) {
        return Container(
          height:
              MediaQuery.of(context).size.height * 0.95, // Almost full-screen
          padding: const EdgeInsets.all(16.0),
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 34),
                    // Invoice Details
                    Text(
                      'Invoice Details',
                      style: theme.textTheme.titleLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Invoice ID: ${AppConstants.invoiceIdPrefix}${invoice.invoiceNumber}',
                      style: theme.textTheme.bodyLarge,
                    ),
                    Text(
                      'Invoice Date: ${DateFormat('dd-MM-yyyy').format(invoice.invoiceDate!)}',
                      style: theme.textTheme.bodyLarge,
                    ),
                    Text(
                      'Payment Method: ${invoice.paymentMethod}',
                      style: theme.textTheme.bodyLarge,
                    ),

                    const SizedBox(height: 20),

                    // Client Details
                    Text(
                      'Client Details',
                      style: theme.textTheme.titleLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Text('Client Name: ${invoice.clientName}',
                        style: theme.textTheme.bodyLarge),
                    // Text('Contact Person: John Doe',
                    //     style: theme.textTheme.bodyLarge),
                    Text('Address: ${invoice.clientAddress}',
                        style: theme.textTheme.bodyLarge),
                    // Text('Shipping Address: 456, Another St, City, ZIP',
                    //     style: theme.textTheme.bodyLarge),
                    Text('Email: ${invoice.clientEmail}',
                        style: theme.textTheme.bodyLarge),
                    Text('Phone: +91 ${invoice.clientPhone}',
                        style: theme.textTheme.bodyLarge),
                    const SizedBox(height: 20),

                    // Item Details
                    Text(
                      'Item Details',
                      style: theme.textTheme.titleLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        // decoration: BoxDecoration(border: Border.all()),
                        border: TableBorder.symmetric(
                            inside: BorderSide(
                                color: Colors.white.withOpacity(0.3))),
                        columnSpacing: 0,
                        headingRowColor: WidgetStateProperty.all(
                          // theme.colorScheme.primaryContainer,
                          Colors.white12,
                        ),
                        columns: [
                          DataColumn(
                            label: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Text('S.No',
                                  style: theme.textTheme.bodyMedium),
                            ),
                          ),
                          DataColumn(
                            label: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              child: Text(
                                'Item',
                                style: theme.textTheme.bodyMedium,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Text('Quantity',
                                  style: theme.textTheme.bodyMedium),
                            ),
                          ),
                          DataColumn(
                            label: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Text('Unit Price',
                                  style: theme.textTheme.bodyMedium),
                            ),
                          ),
                          DataColumn(
                            label: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Text('Tax',
                                  style: theme.textTheme.bodyMedium),
                            ),
                          ),
                          DataColumn(
                            label: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Text('Discount',
                                  style: theme.textTheme.bodyMedium),
                            ),
                          ),
                          DataColumn(
                            label: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Text('Total',
                                  style: theme.textTheme.bodyMedium),
                            ),
                          ),
                        ],

                        rows: invoice.billItems!.asMap().entries.map((item) {
                          int serialNo = item.key + 1;
                          return DataRow(cells: [
                            DataCell(
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                alignment: Alignment.center,
                                child: Text(
                                  "$serialNo",
                                  // "0",
                                  style: theme.textTheme.bodySmall,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            DataCell(
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                alignment: Alignment.center,
                                child: Text(
                                  item.value.itemName!,
                                  style: theme.textTheme.bodySmall,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            DataCell(
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                alignment: Alignment.center,
                                child: Text(
                                  item.value.quantity.toString(),
                                  style: theme.textTheme.bodySmall,
                                ),
                              ),
                            ),
                            DataCell(
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                alignment: Alignment.center,
                                child: Text(
                                  '₹${item.value.unitPrice}',
                                  style: theme.textTheme.bodySmall,
                                ),
                              ),
                            ),
                            DataCell(
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                alignment: Alignment.center,
                                child: Text(
                                  '${item.value.tax}%',
                                  style: theme.textTheme.bodySmall,
                                ),
                              ),
                            ),
                            DataCell(
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                alignment: Alignment.center,
                                child: Text(
                                  '${item.value.discount}%',
                                  style: theme.textTheme.bodySmall,
                                ),
                              ),
                            ),
                            DataCell(
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                alignment: Alignment.center,
                                child: Text('₹${item.value.totalPrice}',
                                    style: theme.textTheme.bodySmall),
                              ),
                            ),
                          ]);
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Summary
                    Text(
                      'Summary',
                      style: theme.textTheme.titleLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Subtotal: ₹${invoice.subtotal}',
                      style: theme.textTheme.bodyLarge,
                    ),
                    Text(
                      'Extra Discount: ₹${invoice.extraDiscount}',
                      style: theme.textTheme.bodyLarge,
                    ),
                    Text(
                      'Total Discount: ₹${invoice.totalDiscount}',
                      style: theme.textTheme.bodyLarge,
                    ),
                    Text(
                      'Total Tax: ₹${invoice.totalTaxAmount}',
                      style: theme.textTheme.bodyLarge,
                    ),
                    Text(
                      'Shipping: ₹${invoice.shippingCharges}',
                      style: theme.textTheme.bodyLarge,
                    ),
                    Text(
                      'Grand Total: ₹${invoice.grandTotal}',
                      style: theme.textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Additional Notes
                    Text(
                      'Notes:',
                      style: theme.textTheme.titleLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      invoice.notes!,
                      style: theme.textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
              // Close Button
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: Icon(MdiIcons.closeCircle),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
