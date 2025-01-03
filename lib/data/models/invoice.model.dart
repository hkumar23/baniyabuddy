import 'package:hive/hive.dart';

import '../../constants/app_constants.dart';
import 'bill_item.model.dart';
import '../../utils/hive_adapter_typeids.dart';
import '../../utils/hive_adapter_names.dart';

part 'invoice.model.g.dart';

@HiveType(
  typeId: HiveAdapterTypeids.invoice,
  adapterName: HiveAdapterNames.invoice,
)
class Invoice {
  @HiveField(0)
  String? docId;
  @HiveField(1)
  bool isSynced;
  // Invoice Details
  @HiveField(2)
  int? invoiceNumber;
  @HiveField(3)
  final DateTime? invoiceDate;
  @HiveField(4)
  final String? paymentMethod;
  // Client Details
  @HiveField(5)
  final String clientName;
  @HiveField(6)
  final String? clientAddress;
  @HiveField(7)
  final String? clientEmail;
  @HiveField(8)
  final String? clientPhone;

  // Summary Details
  @HiveField(9)
  double? subtotal;
  @HiveField(10)
  double? extraDiscount;
  @HiveField(11)
  double? totalDiscount;
  @HiveField(12)
  double? totalTaxAmount;
  @HiveField(13)
  double? grandTotal;
  @HiveField(14)
  final double? shippingCharges;

  @HiveField(15)
  final List<BillItem>? billItems;

  @HiveField(16)
  final String? notes;

  Invoice({
    required this.docId,
    required this.isSynced,
    // Invoice Details
    required this.invoiceNumber,
    required this.invoiceDate,
    required this.paymentMethod,
    // Client Details
    required this.clientName,
    required this.clientAddress,
    required this.clientEmail,
    required this.clientPhone,
    // Summary Details
    required this.subtotal,
    required this.extraDiscount,
    required this.totalDiscount,
    required this.totalTaxAmount,
    required this.grandTotal,
    required this.shippingCharges,
    required this.billItems,
    required this.notes,
  });
  factory Invoice.fromJson(Map<String, dynamic> json) {
    // print(json[AppConstants.billItems]);
    final List<BillItem> billItems = json[AppConstants.billItems]
        .map((item) => BillItem.fromJson(item))
        .toList()
        .cast<BillItem>();
    // print(billItems);
    return Invoice(
      docId: json[AppConstants.docId],
      isSynced: json[AppConstants.isSynced],
      invoiceNumber: json[AppConstants.invoiceNumber],
      invoiceDate: json[AppConstants.invoiceDate].toDate(),
      paymentMethod: json[AppConstants.paymentMethod],
      clientName: json[AppConstants.clientName],
      clientAddress: json[AppConstants.clientAddress],
      clientEmail: json[AppConstants.clientEmail],
      clientPhone: json[AppConstants.clientPhone],
      subtotal: json[AppConstants.subtotal],
      extraDiscount: json[AppConstants.extraDiscount],
      totalDiscount: json[AppConstants.totalDiscount],
      totalTaxAmount: json[AppConstants.totalTaxAmount],
      grandTotal: json[AppConstants.grandTotal],
      shippingCharges: json[AppConstants.shippingCharges],
      billItems: billItems,
      notes: json[AppConstants.notes],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      AppConstants.isSynced: isSynced,
      AppConstants.docId: docId,
      AppConstants.invoiceNumber: invoiceNumber,
      AppConstants.invoiceDate: invoiceDate,
      AppConstants.paymentMethod: paymentMethod,
      AppConstants.clientName: clientName,
      AppConstants.clientAddress: clientAddress,
      AppConstants.clientEmail: clientEmail,
      AppConstants.clientPhone: clientPhone,
      AppConstants.subtotal: subtotal,
      AppConstants.extraDiscount: extraDiscount,
      AppConstants.totalDiscount: totalDiscount,
      AppConstants.totalTaxAmount: totalTaxAmount,
      AppConstants.grandTotal: grandTotal,
      AppConstants.shippingCharges: shippingCharges,
      AppConstants.billItems:
          billItems?.map((BillItem item) => item.toJson()).toList(),
      AppConstants.notes: notes,
    };
  }
}
